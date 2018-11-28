//
//  EpgDetailCell.swift
//  Runner
//
//  Created by patrick on 11/28/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import UIKit

class EpgDetailCell: UITableViewCell{
    
    @IBOutlet weak var laStart: UILabel!
    @IBOutlet weak var laEnd: UILabel!
    @IBOutlet weak var laLabel: UILabel!
    
    override func awakeFromNib() {
//        let selectedView = UIView(frame: CGRect.zero)
//        selectedView.backgroundColor = UIColor(red: 24/255, green: 25/255,blue: 27/255, alpha: 1.0)
//        backgroundView = selectedView
//        let selectedView1 = UIView(frame: CGRect.zero)
//        selectedView1.backgroundColor = UIColor(red: 24/255, green: 25/255,blue: 27/255, alpha: 1.0)
//        selectedBackgroundView = selectedView1
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    func setData(_ epgDetailInfo: EpgDetailInfo){
        laLabel.text = epgDetailInfo.label
        laStart.text = TimeUtil.getTimeString(unixTime: epgDetailInfo.startTime, format: "hh:mm a")
        laEnd.text = TimeUtil.getTimeString(unixTime: epgDetailInfo.endTime, format: "hh:mm a")
        if TimeUtil.getUnixTimestamp() > epgDetailInfo.startTime &&  TimeUtil.getUnixTimestamp() <= epgDetailInfo.endTime{
            laLabel.textColor = UIColor.green
        }
        
    }
}
