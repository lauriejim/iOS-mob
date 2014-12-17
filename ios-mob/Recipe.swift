//
//  Recipe.swift
//  ios-mob
//
//  Created by Kévin Chassagne on 16/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import Foundation

class Recipe  {
    var recipeName = "Title"
    var username = "Bot"
    var message = "Message"
    var channel = "#channel"
    var imageName = "http://lorempixel.com/48/48"
    
    init(recipeName:String, username:String, message:String, channel:String, imageName:String) {
        self.recipeName = recipeName
        self.username = username
        self.message = message
        self.channel = channel
        self.imageName = imageName
    }
}