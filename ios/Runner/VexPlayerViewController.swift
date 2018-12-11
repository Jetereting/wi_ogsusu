//
//  VexPlayerViewController.swift
//  Runner
//
//  Created by patrick on 12/11/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import Foundation
import UIKit
import TXLiteAVSDK_Player
import SnapKit


class VexPlayerViewController: UIViewController {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var controllerView: VideoController!
    
    var url: String!
    var label: String!
    
    var player: TXVodPlayer = TXVodPlayer.init()
    var timer: Timer!
    
    var controllerShowed = true
    let screenw = UIScreen.main.bounds.size.width
    let screenh = UIScreen.main.bounds.size.height
    var statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    
    fileprivate var isFullScreen:Bool {
        get {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerView.delegate = self
        controllerView.setTitle(label)
        startPlay(url)
        print(url)
        addVideoControllerGesture()
    }
    
    func startPlay(_ url: String){
        player.startPlay(url)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        releasePlayer()
    }
    
    func releasePlayer(){
        print("releasePlayer")
        player.pause()
        player.stopPlay()
        player.removeVideoWidget()
    }
    
    
    var isStatusBarHidden = false {
        didSet{
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
}



extension VexPlayerViewController: TXVodPlayListener{
    func onPlayEvent(_ player: TXVodPlayer!, event EvtID: Int32, withParam param: [AnyHashable : Any]!) {
        if(EvtID == PLAY_EVT_PLAY_BEGIN.rawValue){
            print("play start ...")
            controllerView.btnPlay.setImage(UIImage(named: "pause_30"), for: UIControlState.normal)
            controllerView.stopLoading()
            startIntervel()
        }
        
        if EvtID == PLAY_EVT_PLAY_LOADING.rawValue{
            print("buffing...")
            controllerView.startLoading()
            controllerView.alpha = 1.0
        }
    }
    
    func onNetStatus(_ player: TXVodPlayer!, withParam param: [AnyHashable : Any]!) {
        
    }
}


extension VexPlayerViewController: VideoControllerDelegate{
    
    func close(){
        if isFullScreen{
            toPortrait()
            controllerView.updateBtnFullScreenIcon()
        }else{
            print("onClose")
            releasePlayer()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func playOrPause(btnPlay: UIButton) {
        if(player.isPlaying()){
            player.pause()
            btnPlay.setImage(UIImage(named: "play_30"), for: UIControlState.normal)
        }else{
            player.resume()
            btnPlay.setImage(UIImage(named: "pause_30"), for: UIControlState.normal)
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


extension VexPlayerViewController{
    
    func addVideoControllerGesture(){
        controllerView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(onGesture))
        controllerView.addGestureRecognizer(gesture)
    }
    
    
    @objc func onGesture(){
        print("onGesture")
        if(!controllerShowed){
            controllerView.updateSubView(true)
            controllerShowed = true
            startIntervel()
        }else{
            controllerView.updateSubView(false)
            controllerShowed = false
            if(timer != nil){
                timer.invalidate()
                timer = nil
            }
        }
    }
    
    func startIntervel(){
        if(!controllerShowed){
            return
        }
        print("startIntervel")
        if(timer != nil){
            timer.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(timeInterval: 12.00, target: self, selector: #selector(timeAction), userInfo: nil, repeats: false)
    }
    
    @objc func timeAction(){
        print("timeAction")
        controllerView.updateSubView(false)
        controllerShowed = false
    }
    
    func stopIntervel(){
        timer.invalidate()
    }
}
