//
//  EpgDetailProvider.swift
//  Runner
//
//  Created by patrick on 11/28/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol EpgDetailProviderDelegate {
    func epgDetailProviderDelegate(epgDetailInfos: [EpgDetailInfo])
    func epgDetailProviderDelegate(_ message: String, _ error: Error?)
}

class EpgDetailProvider {

    var delegate: EpgDetailProviderDelegate?
    
    let url = "http://extension.vipnow.work/epg/"
    
    func load(channelId: String){
        Alamofire.request(url + channelId, method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success:
                    let result = JSON(data: response.data!)
                    if(result["code"].intValue == 200){
                        var epgDetailInfos = [EpgDetailInfo]()
                        let data = result["data"]
                        for i in 0..<data.count {
                            epgDetailInfos.append(EpgDetailInfo(data[i]))
                        }
                        self.delegate?.epgDetailProviderDelegate(epgDetailInfos: epgDetailInfos)
                    }else{
                        self.delegate?.epgDetailProviderDelegate(result["msg"].stringValue, nil)
                    }
                case .failure(let error):
                    self.delegate?.epgDetailProviderDelegate(error.localizedDescription, error)
                }
        }
    }
}
