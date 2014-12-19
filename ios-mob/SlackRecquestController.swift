//
//  SlackRequestControllerViewController.swift
//  ios-mob
//
//  Created by Kévin Chassagne on 17/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit
import Alamofire

class SlackRequestController: UIViewController {
    
    var token = ""
    var channels = [String]()
    var req = SlackRequest()
    
    func postMessage(channel:String, message:String, botName:String) {
        self.req.setMessage(channel, message: message, botName: botName)
        
        Alamofire.request(.POST, self.req.url + "chat.postMessage", parameters: self.req.params, encoding: ParameterEncoding.URL).responseJSON { (urlRequest:NSURLRequest, urlResponse:NSHTTPURLResponse?, jsonResponse:AnyObject?, error:NSError?) -> Void in
            
            var jsonObject = jsonResponse as NSDictionary
            
            if (jsonObject["error"] != nil) {
                return self.error(jsonObject)
            }
            
            self.success()
        }
    }
    
    func getToken(code:String) {
        var req = SlackRequest()
        req.setCode(code)
        
        Alamofire.request(.POST, req.url + "oauth.access", parameters: req.params, encoding: ParameterEncoding.URL).responseJSON { (urlRequest:NSURLRequest, urlResponse:NSHTTPURLResponse?, jsonResponse:AnyObject?, error:NSError?) -> Void in
            
            var jsonObject = jsonResponse as NSDictionary
            
            if (jsonObject["error"] != nil) {
                return self.error(jsonObject)
            }

            self.token = jsonObject["access_token"] as String
            
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as ViewController
            viewController.tokenId = self.token
            self.navigationController?.pushViewController(viewController, animated: false)
            
        }
    }
    
    func setToken(token:String) {
        self.req.setToken(token)
    }
    
    func getChannelList() {
        Alamofire.request(.POST, self.req.url + "channels.list", parameters: self.req.params, encoding: ParameterEncoding.URL).responseJSON { (urlRequest:NSURLRequest, urlResponse:NSHTTPURLResponse?, jsonResponse:AnyObject?, error:NSError?) -> Void in
            
            var jsonObject = jsonResponse as NSDictionary
            
            if (jsonObject["error"] != nil) {
                return self.error(jsonObject)
            }
            
            var channelsObject = jsonObject["channels"] as NSArray
            
            for var i = 0; i < channelsObject.count; i++ {
                var channelName = channelsObject[i]["name"] as String
                channelName = "#" + channelName
                self.channels.append(channelName)
            }

        }
        
    }
    
    func error(jsonObject:NSDictionary) {
        var viewController: ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as ViewController
        viewController.fail = true
        viewController.tokenId = self.req.params["token"]!
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func success() {
        var viewController: ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as ViewController
        viewController.success = true
        viewController.tokenId = self.req.params["token"]!
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
}
