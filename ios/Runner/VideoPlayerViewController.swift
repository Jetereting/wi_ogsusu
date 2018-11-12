//
//  VideoPlay1Controller.swift
//  Runner
//
//  Created by patrick on 11/3/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import Foundation
import UIKit
import TXLiteAVSDK_Player
import SnapKit

class VideoPlayerViewController: UIViewController{
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var controllerView: VideoController!
    
    var player: TXVodPlayer = TXVodPlayer.init()
    
    lazy var channelProvider = {
        return ChannelProvider()
    }()
    
    var channelId: String!
    var token: String!
    var isFullScreen = false
    
    let screenw = UIScreen.main.bounds.size.width
    let screenh = UIScreen.main.bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.vodDelegate = self
        player.setupVideoWidget(playView, insert: 0)
        
        controllerView.attachController(self)
        controllerView.delegate = self

        channelProvider.loadDelegate = self
        print(channelId)
        if let id = channelId{
            channelProvider.load(channelId: id)
        }
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
        player.startPlay(url)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        releasePlayer()
    }
    
    func releasePlayer(){
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


extension VideoPlayerViewController: ChannelProviderDelegate{
    
    func loadSuccess(channelInfo: ChannelInfo) {
        print(channelInfo)
        parseUrl(channelInfo)
    }
    
    func loadFailure(_ message: String, _ error: Error?) {
        print(message)
    }
    
}


extension VideoPlayerViewController: TXVodPlayListener{
    func onPlayEvent(_ player: TXVodPlayer!, event EvtID: Int32, withParam param: [AnyHashable : Any]!) {
        if(EvtID == PLAY_EVT_PLAY_BEGIN.rawValue){
            controllerView.btnPlay.setImage(UIImage(named: "pause_30"), for: UIControlState.normal)
        }
        
        if (EvtID == PLAY_EVT_PLAY_PROGRESS.rawValue) {
            // 加载进度, 单位是秒, 小数部分为毫秒
            var playable = param[EVT_PLAYABLE_DURATION]
//            [_loadProgressBar setValue:playable];
            // 播放进度, 单位是秒, 小数部分为毫秒
            var progress = param[EVT_PLAY_PROGRESS];
//            [_seekProgressBar setValue:progress];
            var totalDuration = param[EVT_PLAY_DURATION];
        }
    }
    
    func onNetStatus(_ player: TXVodPlayer!, withParam param: [AnyHashable : Any]!) {
        
    }
    
}


extension VideoPlayerViewController: VideoControllerDelegate{
    
    func close(){
        releasePlayer()
        self.dismiss(animated: false, completion: nil)
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
    
    func fullScreen(isFullScreen: Bool) {
        self.isFullScreen = isFullScreen
        if isFullScreen {
            toLandspaceRight()
        }else{
            toPortrait()
        }
    }
    
    func toLandspaceRight(){
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform.identity
                .rotated(by:CGFloat(Double.pi/2))
//                    .translatedBy(x: (screenh - self.contentView.bounds.height) / 2, y: 0)
//                    .scaledBy(x: screenh / self.contentView.bounds.width, y: screenw / self.contentView.bounds.height)
            self.view.bounds = CGRect(x:0,y:0,width:self.screenh,height: self.screenw);
            self.viewWillLayoutSubviews();
            self.view.layoutIfNeeded();
            self.isStatusBarHidden = true
        }
    }
    
    func toPortrait(){
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform.identity
            self.view.bounds = CGRect(x:0,y:0,width: self.screenw, height: self.screenh);
            self.viewWillLayoutSubviews();
            self.view.layoutIfNeeded();
            self.isStatusBarHidden = false
        }
    }
    
}
