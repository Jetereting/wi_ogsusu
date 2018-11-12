//
//  VideoController.swift
//  Runner
//
//  Created by patrick on 11/5/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import TXLiteAVSDK_Player

protocol VideoControllerDelegate {
    func close()
    func playOrPause(btnPlay: UIButton)
    func fullScreen(isFullScreen: Bool)
}

class VideoController: UIView{

    var delegate: VideoControllerDelegate?
    var controller: UIViewController?
    var controlView: UIView!
    var btnClose: UIButton!
    var btnPlay: UIButton!
    var btnFulScreen: UIButton!
    var laPlayDuration: UILabel!
    var laTotalDuration: UILabel!
    var loadingView: UIActivityIndicatorView!
    var progressBar: UIProgressView!
    
    var isFullScreen: Bool = false
    var isPlaying: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
    func initUI(){
        createControlView()
    }
    
    func attachController(_ controller: UIViewController){
        self.controller = controller
    }
    
    func createControlView(){
        controlView = UIView.init()
        controlView.backgroundColor = UIColor.clear
        self.addSubview(controlView)
        controlView.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.bottom.equalTo(self)
            $0.left.equalTo(self)
            $0.right.equalTo(self)
        }
        createCloseButton()
        createLoadingView()
        createPlayButton()
        createPlayDuration()
        createFullScreenButton()
        createTotalDuration()
        createProgressView()
    }
    
    func createCloseButton(){
        btnClose = UIButton.init()
        btnClose.setImage(UIImage(named: "close30"), for: UIControlState.normal)
        btnClose.addTarget(self, action: #selector(close), for: UIControlEvents.touchUpInside)
        controlView.addSubview(btnClose)
        btnClose.snp.makeConstraints {
            $0.top.equalTo(controlView).offset(20)
            $0.left.equalTo(controlView).offset(15)
            $0.width.equalTo(25)
            $0.height.equalTo(25)
        }
    }
    
    @objc private func close() {
        print("close")
        if let delega = self.delegate{
            delega.close();
        }
    }
    
    func createLoadingView(){
        loadingView = UIActivityIndicatorView.init()
        loadingView.color = UIColor.white
        controlView.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.center.equalTo(controlView.snp.center)
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
    }
    
    
    func createFullScreenButton(){
        btnFulScreen = UIButton.init()
        let icon = isFullScreen ? UIImage(named: "full_out_30"): UIImage(named: "full_in_30")
        btnFulScreen.setImage(icon, for: UIControlState.normal)
        btnFulScreen.addTarget(self, action: #selector(fullScreen), for: UIControlEvents.touchUpInside)
        controlView.addSubview(btnFulScreen)
        btnFulScreen.snp.makeConstraints {
            $0.bottom.equalTo(controlView).offset(-5)
            $0.right.equalTo(controlView).offset(-10)
            $0.width.equalTo(25)
            $0.height.equalTo(25)
        }
    }
    
    @objc private func fullScreen() {
        isFullScreen = !isFullScreen
        if let delega = self.delegate{
            delega.fullScreen(isFullScreen: isFullScreen)
        }
        if(isFullScreen){
            btnFulScreen.setImage(UIImage(named: "full_out_30"), for: UIControlState.normal)
        }else{
            btnFulScreen.setImage(UIImage(named: "full_in_30"), for: UIControlState.normal)
        }
    }
    
    func createPlayButton(){
        btnPlay = UIButton.init()
        let icon = isPlaying ? UIImage(named: "pause_30"): UIImage(named: "play_30")
        btnPlay.setImage(icon, for: UIControlState.normal)
        btnPlay.addTarget(self, action: #selector(play), for: UIControlEvents.touchUpInside)
        controlView.addSubview(btnPlay)
        btnPlay.snp.makeConstraints {
            $0.bottom.equalTo(controlView).offset(-5)
            $0.left.equalTo(controlView).offset(10)
            $0.width.equalTo(25)
            $0.height.equalTo(25)
        }
    }
    
    @objc private func play() {
        isPlaying = !isPlaying
        if let delega = self.delegate{
            delega.playOrPause(btnPlay: btnPlay)
        }
    }
    
    func createPlayDuration(){
        laPlayDuration = UILabel.init()
        laPlayDuration.numberOfLines = 1
        laPlayDuration.text = "00:00"
        laPlayDuration.font = UIFont.boldSystemFont(ofSize: 12)
        laPlayDuration.textColor = UIColor.white
        controlView.addSubview(laPlayDuration)
        laPlayDuration.snp.makeConstraints {
            $0.bottom.equalTo(controlView).offset(-5)
            $0.left.equalTo(btnPlay.snp.right).offset(10)
            $0.height.equalTo(25)
        }
    }
    
    func createTotalDuration(){
        laTotalDuration = UILabel.init()
        laTotalDuration.numberOfLines = 1
        laTotalDuration.text = "00:00"
        laTotalDuration.font = UIFont.boldSystemFont(ofSize: 12)
        laTotalDuration.textColor = UIColor.white
        controlView.addSubview(laTotalDuration)
        laTotalDuration.snp.makeConstraints {
            $0.bottom.equalTo(controlView).offset(-5)
            $0.right.equalTo(btnFulScreen.snp.left).offset(-10)
            $0.height.equalTo(25)
        }
    }
    
    
    
    func createProgressView(){
        progressBar = UIProgressView.init()
        controlView.addSubview(progressBar)
        progressBar.snp.makeConstraints {
            $0.bottom.equalTo(controlView).offset(-17)
            $0.left.equalTo(laPlayDuration.snp.right).offset(10)
            $0.right.equalTo(laTotalDuration.snp.left).offset(-10)
            $0.height.equalTo(1)
        }
    }
    
}
