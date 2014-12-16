//
//  slackRequest.swift
//  ios-mob
//
//  Created by Jim LAURIE on 16/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit
import Alamofire

class slackRequest: NSObject {
    let token = "xoxp-3221071404-3221071414-3221836016-5659d9"
    let url = "https://slack.com/api/"
    var params:[String: String]!
    
    override init() {
        self.params = [
            "token": token
        ]
    }
    
    func setMessage(channel:String, message:String, botName:String) {
        self.params = [
            "token": token,
            "channel": channel,
            "username": botName,
            "text": message
        ]
    }
}
