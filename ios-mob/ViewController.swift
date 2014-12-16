//
//  ViewController.swift
//  ios-mob
//
//  Created by Jim LAURIE on 15/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBAction func pushButton(sender: AnyObject) {
        let apiUrl = "https://slack.com/api/"
        let token = "xoxp-3221071404-3221071414-3221836016-5659d9"
        let channel = "#test"
        var slackParams = [
            "token": token,
            "channel": channel,
            "username": "Jim",
            "text": "console.log('coucou');"
        ]
        Alamofire.request(.POST, apiUrl + "chat.postMessage", parameters: slackParams)
            .response { (request, response, data, error) in
                println(request)
                println(response)
                println(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

