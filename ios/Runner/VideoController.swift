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
    func fullScreen()
}

class VideoController: UIView{

    var delegate: VideoControllerDelegate?
    var controlView: UIView!
    var btnClose: UIButton!
    var laTitle: UILabel!
    var btnPlay: UIButton!
    var btnFulScreen: UIButton!
    var laPlayDuration: UILabel!
    var laTotalDuration: UILabel!
    var loadingView: UIActivityIndicatorView!
    var progressBar: UIProgressView!
    
    var isPlaying: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    func initUI(){
        createControlView()
        startLoading()
    }
    
    func createControlView(){
        controlView = UIView.init()
        controlView.backgroundColor = UIColor.clear
        self.addSubview(controlView)
        controlView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        createCloseButton()
        createTitle()
        createLoadingView()
        createPlayButton()
        createPlayDuration()
        createFullScreenButton()
        createTotalDuration()
        createProgressView()
    }
    
    func updateSubView(_ isShow: Bool){
        let alpha: CGFloat = isShow ? 1.0 : 0.0
        btnClose.alpha = alpha
        laTitle.alpha = alpha
        btnPlay.alpha = alpha
        btnFulScreen.alpha = alpha
        laPlayDuration.alpha = alpha
        laTotalDuration.alpha = alpha
        progressBar.alpha = alpha
        loadingView.alpha = alpha
    }

    
    func createCloseButton(){
        btnClose = UIButton.init()
        btnClose.setImage(UIImage(named: "back_30"), for: UIControlState.normal)
        btnClose.addTarget(self, action: #selector(close), for: UIControlEvents.touchUpInside)
        controlView.addSubview(btnClose)
        btnClose.snp.makeConstraints {
            $0.top.equalTo(controlView).offset(15)
            $0.left.equalTo(controlView)
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
    }
    
    @objc private func close() {
        if let delega = self.delegate{
            delega.close();
        }
    }
    
    func createTitle(){
        laTitle = UILabel.init()
        laTitle.numberOfLines = 1
        laTitle.font = UIFont.boldSystemFont(ofSize: 16)
        laTitle.textColor = UIColor.white
        controlView.addSubview(laTitle)
        laTitle.snp.makeConstraints {
            $0.top.equalTo(controlView).offset(30)
            $0.left.equalTo(btnClose.snp.right).offset(5)
            $0.height.equalTo(30)
        }
    }
    
    func setTitle(_ title: String){
        laTitle.text = title
    }
    
    func createLoadingView(){
        loadingView = UIActivityIndicatorView.init(activityIndicatorStyle:.whiteLarge)
        loadingView.color = UIColor.white
        loadingView.hidesWhenStopped = true
        controlView.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.center.equalTo(controlView.snp.center)
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
    }
    
    func startLoading(){
        loadingView.startAnimating()
    }
    
    func stopLoading(){
        loadingView.stopAnimating()
    }
    
    
    func createFullScreenButton(){
        btnFulScreen = UIButton.init()
        updateBtnFullScreenIcon()
        btnFulScreen.addTarget(self, action: #selector(fullScreen), for: UIControlEvents.touchUpInside)
        controlView.addSubview(btnFulScreen)
        btnFulScreen.snp.makeConstraints {
            $0.bottom.equalTo(controlView).offset(-5)
            $0.right.equalTo(controlView).offset(-10)
            $0.width.equalTo(25)
            $0.height.equalTo(25)
        }
    }
    
    func updateBtnFullScreenIcon(){
        let icon = isFullScreen ? UIImage(named: "full_out_30"): UIImage(named: "full_in_30")
        btnFulScreen.setImage(icon, for: UIControlState.normal)
    }
    
    fileprivate var isFullScreen:Bool {
        get {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    
    @objc private func fullScreen() {
        if let delega = self.delegate{
            delega.fullScreen()
        }
        updateBtnFullScreenIcon()
        self.controlView.layoutIfNeeded();
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
