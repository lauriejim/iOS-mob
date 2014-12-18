//
//  CustomCell.swift
//  ios-mob
//
//  Created by Kévin Chassagne on 16/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var botLabel: UILabel!
    @IBOutlet weak var botImageView: UIImageView!
    @IBOutlet weak var postButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(recipeNameLabel:String, messageLabel:String, channelLabel:String, botLabel:String, index:Int) {
        // Image
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.botImageView.image =  UIImage(data: NSData(contentsOfURL: NSURL(string:"http://lorempixel.com/48/48")!)!)
            // Border radius
            self.botImageView.layer.cornerRadius = self.botImageView.frame.size.width / 2;
            self.botImageView.clipsToBounds = true;
        })

        self.recipeNameLabel.text = recipeNameLabel
        self.messageLabel.text = messageLabel
        self.channelLabel.text = channelLabel
        self.botLabel.text = botLabel
        self.postButton.tag = index
    }
    
}
