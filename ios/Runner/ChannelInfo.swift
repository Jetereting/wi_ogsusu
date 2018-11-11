//
//  ChannelInfo.swift
//  BVISION
//
//  Created by patrick on 2018/5/28.
//  Copyright © 2018 wiatec. All rights reserved.
//

//
//  VodChannelInfo.swift
//  BVISION
//
//  Created by patrick on 2018/5/28.
//  Copyright © 2018 wiatec. All rights reserved.
//
import SwiftyJSON

struct ChannelInfo {
    var id: Int = 0
    var channelId: String = ""
    var tag: String = ""
    var label: String = ""
    var name: String = ""
    var type: Int = 0
    var visible: Bool = false
    var blocked: Bool = false
    var sync: Int = 0
    var flag: Int = 0
    var url: String = ""
    var icon: String = ""
    var remark: String = ""
    
    
    init(_ jsonData: JSON) {
        id = jsonData["id"].intValue
        channelId = jsonData["channelId"].stringValue
        tag = jsonData["tag"].stringValue
        label = jsonData["label"].stringValue
        name = jsonData["name"].stringValue
        type = jsonData["type"].intValue
        visible = jsonData["visible"].boolValue
        blocked = jsonData["blocked"].boolValue
        sync = jsonData["sync"].intValue
        flag = jsonData["flag"].intValue
        url = jsonData["url"].stringValue
        icon = jsonData["icon"].stringValue
        remark = jsonData["remark"].stringValue
    }
}

