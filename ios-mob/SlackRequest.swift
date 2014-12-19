//
//  SlackRequest.swift
//  ios-mob
//
//  Created by Kévin Chassagne on 17/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit

class SlackRequest: NSObject {
    var token = ""
    var params:[String: String]!
    let url = "https://slack.com/api/"
    
    override init() {
        self.params = [
            "token": self.token
        ]
    }
    
    func setMessage(channel:String, message:String, botName:String) {
        self.params = [
            "token": self.token,
            "channel": channel,
            "username": botName,
            "text": message
        ]
    }
    
    func setCode(code:String) {
        self.params = [
            "client_id": "3221071404.3240178857",
            "client_secret": "292827669602c867cd940a1276a2c358",
            "code": code
        ]
    }
    
    func setToken(token:String) {
        self.token = token
        self.params = [
            "token": token
        ]
    }
}
