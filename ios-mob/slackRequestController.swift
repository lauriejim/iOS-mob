//
//  slackRequestController.swift
//  ios-mob
//
//  Created by Jim LAURIE on 16/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit
import Alamofire

class slackRequestController: UIViewController {
    func postMessage(channel:String, message:String, botName:String) {
        var req = slackRequest()
        req.setMessage(channel, message: message, botName: botName)
        
        Alamofire.request(.POST, req.url + "chat.postMessage", parameters: req.params, encoding: ParameterEncoding.URL).responseJSON { (urlRequest:NSURLRequest, urlResponse:NSHTTPURLResponse?, jsonResponse:AnyObject?, error:NSError?) -> Void in
            
            var jsonObject = jsonResponse as NSDictionary
            
            if (jsonObject["error"] != nil) {
                return self.error(jsonObject)
            }
        }
    }
    
    func getChannelList() -> NSArray? {
        var req = slackRequest()
        var channels = [String]()
        
        Alamofire.request(.POST, req.url + "channels.list", parameters: req.params, encoding: ParameterEncoding.URL).responseJSON { (urlRequest:NSURLRequest, urlResponse:NSHTTPURLResponse?, jsonResponse:AnyObject?, error:NSError?) -> Void in
            
            var jsonObject = jsonResponse as NSDictionary
            
            if (jsonObject["error"] != nil) {
                return self.error(jsonObject)
            }
            
            var channelsObject = jsonObject["channels"] as NSArray
            
            for var i = 0; i < channelsObject.count; i++ {
                var channelName = channelsObject[i]["name"] as String
                channelName = "#" + channelName
                channels.append(channelName)
            }
        }
        
        return channels
    }
    
    func error(jsonObject:NSDictionary) {
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = jsonObject["error"] as String
        alert.addButtonWithTitle("Back")
        alert.show()
    }

}
