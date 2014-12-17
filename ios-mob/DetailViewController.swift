//
//  DetailViewController.swift
//  ios-mob
//
//  Created by Kévin Chassagne on 16/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    var titleString: String?
    var messageString: String?
    var channelString: String?
    var usernameString: String?
    var imageString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.titleLabel.text = titleString
        self.messageLabel.text = messageString
        self.channelLabel.text = channelString
        self.usernameLabel.text = usernameString
        // Image
        // self.imageLabel.image = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
