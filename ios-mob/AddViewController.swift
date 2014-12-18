//
//  AddViewController.swift
//  ios-mob
//
//  Created by Kévin Chassagne on 16/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var channelsList:[String] = []
    var currentChannel = "Aucun channel"
    var token = ""
    
    @IBOutlet weak var recipeNameField: UITextField!
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var botNameField: UITextField!
    @IBOutlet weak var addTableView: UITableView!
    @IBOutlet weak var channelPicker: UIPickerView!
    // @IBOutlet weak var imageField: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        // Close keyboard
        var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        addTableView.addGestureRecognizer(tap)
        
        self.recipeNameField.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.recipeNameField.layer.borderWidth = 1.0
        self.recipeNameField.layer.cornerRadius = 8
        self.botNameField.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.botNameField.layer.borderWidth = 1.0
        self.botNameField.layer.cornerRadius = 8
        self.messageField.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.messageField.layer.borderWidth = 1.0
        self.messageField.layer.cornerRadius = 8
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveRecipe(sender: AnyObject) {
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        var itemList:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        
        var dataSet: NSMutableDictionary = NSMutableDictionary()
        dataSet.setObject(recipeNameField.text, forKey: "recipeName")
        dataSet.setObject(messageField.text, forKey: "message")
        dataSet.setObject(currentChannel as String, forKey: "channel")
        dataSet.setObject(botNameField.text, forKey: "username")
        // dataSet.setObject(imageField.image, forKey: "image")
        
        if (itemList != nil) {
            var newMutableList: NSMutableArray = NSMutableArray()
            
            for dict:AnyObject in itemList! {
                newMutableList.addObject(dict as NSDictionary)
            }
            
            userDefaults.removeObjectForKey("itemList")
            newMutableList.addObject(dataSet)
            userDefaults.setObject(newMutableList, forKey: "itemList")
            
        } else {
            itemList = NSMutableArray()
            itemList!.addObject(dataSet)
            userDefaults.setObject(itemList, forKey: "itemList")
        }
        
        userDefaults.synchronize()
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as ViewController
        viewController.tokenId = self.token
        self.navigationController?.pushViewController(viewController, animated: false)

    }
    
    @IBAction func closeAddView(sender: AnyObject) {
        var viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as ViewController
        viewController.tokenId = self.token
        self.navigationController?.pushViewController(viewController, animated: false)
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
    
    func DismissKeyboard(){
        addTableView.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var viewController = segue.destinationViewController as ViewController
        viewController.tokenId = self.token
    }
}
