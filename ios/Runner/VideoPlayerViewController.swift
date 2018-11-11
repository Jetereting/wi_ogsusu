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

class VideoPlayerViewController: UIViewController{
    
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var controllerView: VideoController!
    
    var player: TXVodPlayer = TXVodPlayer.init()
    
    lazy var channelProvider = {
        return ChannelProvider()
    }()
    
    var channelId: String!
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerView.attachController(self)
        controllerView.videoControllerDelegate = self
        player.setupVideoWidget(playView, insert: 0)
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
        print("viewDidDisappear")
        releasePlayer()
    }
    
    func releasePlayer(){
        print("6565")
        player.pause()
        player.stopPlay()
        player.removeVideoWidget()
    }
    
}


extension VideoPlayerViewController: ChannelProviderDelegate{
    
    func loadSuccess(channelInfo: ChannelInfo) {
        print(1)
        print(channelInfo)
        parseUrl(channelInfo)
    }
    
    func loadFailure(_ message: String, _ error: Error?) {
        print(message)
    }
    
    
}


extension VideoPlayerViewController: VideoControllerDelegate{
    
    func close(){
        releasePlayer()
        self.dismiss(animated: false, completion: nil)
    }
}
