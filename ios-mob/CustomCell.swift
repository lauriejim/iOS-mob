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
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(recipeNameLabel:String, messageLabel:String, channelLabel:String, botLabel:String, botImage:String, index:Int) {
        self.recipeNameLabel.text = recipeNameLabel
        self.messageLabel.text = messageLabel
        self.channelLabel.text = channelLabel
        self.botLabel.text = botLabel
        self.botImageView.image = UIImage(named: botImage)
        self.postButton.tag = index
        self.editButton.tag = index
    }
    
}
