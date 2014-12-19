//
//  EditViewController.swift
//  ios-mob
//
//  Created by Kévin Chassagne on 16/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var token = ""
    var channelsList:[String] = []
    var currentChannel = "0 channel"
    
    var index:Int?
    var message = ""
    var botname = ""
    var channel = ""
    var recipeName = ""
    
    @IBOutlet weak var titleRecipe: UITextField!
    @IBOutlet weak var messageRecipe: UITextView!
    @IBOutlet weak var channelPicker: UILabel!
    @IBOutlet weak var botName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style
        self.titleRecipe.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.titleRecipe.layer.borderWidth = 1.0
        self.titleRecipe.layer.cornerRadius = 8
        self.botName.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.botName.layer.borderWidth = 1.0
        self.botName.layer.cornerRadius = 8
        self.messageRecipe.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.messageRecipe.layer.borderWidth = 1.0
        self.messageRecipe.layer.cornerRadius = 8
        
        // Data
        self.titleRecipe.text = recipeName
        self.messageRecipe.text = message
        self.botName.text = botname
    }
    
    @IBAction func saveEdition(sender: AnyObject) {
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var itemList:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        
        var dataSet: NSMutableDictionary = NSMutableDictionary()
        dataSet.setObject(titleRecipe.text, forKey: "recipeName")
        dataSet.setObject(messageRecipe.text, forKey: "message")
        dataSet.setObject(currentChannel as String, forKey: "channel")
        dataSet.setObject(botName.text, forKey: "username")
        // dataSet.setObject(imageField.image, forKey: "image")
        
        if (itemList != nil) {
            var newMutableList: NSMutableArray = NSMutableArray()
            
            for dict:AnyObject in itemList! {
                newMutableList.addObject(dict as NSDictionary)
            }
            
            newMutableList.replaceObjectAtIndex(self.index!, withObject: dataSet)
            userDefaults.setObject(newMutableList, forKey: "itemList")
            
        }
        
        userDefaults.synchronize()
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as ViewController
        viewController.tokenId = self.token
        self.navigationController?.pushViewController(viewController, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var viewController = segue.destinationViewController as ViewController
        viewController.tokenId = self.token
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return channelsList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(channelsList[row])"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentChannel = channelsList[row] as String
    }
}
