//
//  VexViewController.swift
//  Runner
//
//  Created by patrick on 12/11/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import Foundation
import UIKit
import BMPlayer

class VexViewController: UIViewController{
    
    
    @IBOutlet weak var player: BMCustomPlayer!
    var url: String!
    var label: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPlayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !player.isPlaying{
            player.autoPlay()
        }
    }
    
    func initPlayer(){
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true {
                return
            }else{
                self.dismiss(animated: true, completion: nil)
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        let asset = BMPlayerResource(url: URL(string: url)!, name: label, cover: nil, subtitle: nil)
        player.setVideo(resource: asset)
        player.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player.pause()
    }
    
    deinit {
        player.prepareToDealloc()
    }
    
}

// MARK:- BMPlayerDelegate
extension VexViewController: BMPlayerDelegate {
    
    // Call when player orinet changed
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        player.snp.remakeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            if isFullscreen {
                make.bottom.equalTo(view.snp.bottom)
            } else {
                make.height.equalTo(view.snp.width).multipliedBy(9.0/16.0).priority(500)
            }
        }
    }
    
    // Call back when playing state changed, use to detect is playing or not
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        print("| BMPlayerDelegate | playerIsPlaying | playing - \(playing)")
    }
    
    // Call back when playing state changed, use to detect specefic state like buffering, bufferfinished
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        print("| BMPlayerDelegate | playerStateDidChange | state - \(state)")
    }
    
    // Call back when play time change
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        //                print("| BMPlayerDelegate | playTimeDidChange | \(currentTime) of \(totalTime)")
    }
    
    // Call back when the video loaded duration changed
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        //        print("| BMPlayerDelegate | loadedTimeDidChange | \(loadedDuration) of \(totalDuration)")
    }
}


