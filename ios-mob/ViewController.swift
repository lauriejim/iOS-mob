//
//  ViewController.swift
//  ios-mob
//
//  Created by Jim LAURIE on 15/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var channelInput: UITextField!
    @IBOutlet weak var botNameInput: UITextField!
    @IBOutlet weak var messageInput: UITextField!
    
    @IBAction func pushButton(sender: AnyObject) {
        var channel = channelInput.text
        var botName = botNameInput.text
        var message = messageInput.text
        
        slackRequestController().postMessage(channel, message: message, botName: botName)
        
    }
    @IBAction func listChannels(sender: AnyObject) {
        var array = slackRequestController().getChannelList()
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

