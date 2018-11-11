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
}

class VideoController: UIView{

    var videoControllerDelegate: VideoControllerDelegate?
    var controller: UIViewController?
    var controlView: UIView!
    var btnClose: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
    func initUI(){
        createControlView()
        createCloseButton()
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
        if let delegate = videoControllerDelegate{
            delegate.close();
        }
    }
    
}
