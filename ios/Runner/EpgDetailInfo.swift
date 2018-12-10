//
//  EpgDetailInfo.swift
//  Runner
//
//  Created by patrick on 11/28/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import SwiftyJSON

struct EpgDetailInfo {
    var channelId: String = ""
    var startTime: Int = 0
    var endTime: Int = 0
    var label: String = ""
    
    init() {
        
    }
    
    init(_ jsonData: JSON) {
        channelId = jsonData["channelId"].stringValue
        startTime = jsonData["startTime"].intValue
        endTime = jsonData["endTime"].intValue
        label = jsonData["label"].stringValue
    }
}
