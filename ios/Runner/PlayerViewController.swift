//
//  PlayerViewController.swift
//  Runner
//
//  Created by patrick on 11/27/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import UIKit
import KSYMediaPlayer
import NotificationCenter

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var maskView: VideoController!
    
    lazy var channelProvider = {
        return ChannelProvider()
    }()
    
    var channelId: String!
    var token: String!
    
    var player: KSYMoviePlayerController?
    var videoController: VideoController!
    
    
    var statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    fileprivate var isFullScreen:Bool {
        get {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channelProvider.loadDelegate = self
        if let id = channelId{
            channelProvider.load(channelId: id)
        }
        maskView.delegate = self
        maskView.autoresizesSubviews = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.stop()
        removeObservers()
    }
    

}

extension PlayerViewController: ChannelProviderDelegate{
    
    func loadSuccess(channelInfo: ChannelInfo) {
        parseUrl(channelInfo)
    }
    
    func loadFailure(_ message: String, _ error: Error?) {
        print(message)
    }
    
    func parseUrl(_ channelInfo: ChannelInfo){
        if let playUrl = AESUtil.decrypt(channelInfo.url){
            var uu = playUrl
            if playUrl.contains("#"){
                uu = playUrl.components(separatedBy: "#")[0]
            }
            uu = uu + "?token=" + token
            print(uu)
            startPlay(uu)
        }
    }
    
    func startPlay(_ url: String){
        player = KSYMoviePlayerController.init(contentURL: URL.init(string: url))
        player?.controlStyle = MPMovieControlStyle.none
        player?.view.frame = playView.bounds
        playView.addSubview((player?.view)!)
        playView.autoresizesSubviews = true
        player?.view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        player?.shouldAutoplay = true
        player?.scalingMode = MPMovieScalingMode.aspectFit
        player?.prepareToPlay()
        setupObservers()
    }
    
    
    func setupObservers(){
        NotificationCenter.default.addObserver(self, selector:  #selector(didChangeNotification), name: NSNotification.Name.MPMediaPlaybackIsPreparedToPlayDidChange, object: nil)
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didChangeNotification(notify: Notification){
        if NSNotification.Name.MPMediaPlaybackIsPreparedToPlayDidChange == notify.name{
            maskView.stopLoading()
        }
    }
}



extension PlayerViewController: VideoControllerDelegate{
    func close() {
        if isFullScreen{
            toPortrait()
            maskView.updateBtnFullScreenIcon()
        }else{
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func playOrPause(btnPlay: UIButton) {
        if let play = player{
            if play.isPlaying(){
                play.pause()
                btnPlay.setImage(UIImage(named: "play_30"), for: UIControlState.normal)
            }else{
                play.play()
                btnPlay.setImage(UIImage(named: "pause_30"), for: UIControlState.normal)
            }
        }
    }
    
    func fullScreen() {
        if !isFullScreen {
            toLandspaceRight()
        }else{
            toPortrait()
        }
    }
    
    func toLandspaceRight(){
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        statusBar.alpha = 0.0
    }
    
    func toPortrait(){
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        statusBar.alpha = 1.0
    }
    
    
    
}
