//
//  ChannelProvider.swift
//  Runner
//
//  Created by patrick on 11/1/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ChannelProviderDelegate {
    func loadSuccess(channelInfo: ChannelInfo)
    func loadFailure(_ message: String, _ error: Error?)
}

class ChannelProvider {
    
    var loadDelegate: ChannelProviderDelegate?
    
    let channelUrl = "http://channel.vipnow.work:10220/channel/"
    
    func load(channelId: String){
        Alamofire.request(channelUrl + channelId, method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success:
                    let result = JSON(data: response.data!)
                    if(result["code"].intValue == 200){
                        let channelInfo = ChannelInfo(result["data"])
                        self.loadDelegate?.loadSuccess(channelInfo: channelInfo)
                    }else{
                        self.loadDelegate?.loadFailure(result["msg"].stringValue, nil)
                    }
                case .failure(let error):
                    self.loadDelegate?.loadFailure(error.localizedDescription, error)
                }
        }
    }
}
