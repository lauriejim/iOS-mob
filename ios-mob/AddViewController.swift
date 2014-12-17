//
//  AddViewController.swift
//  ios-mob
//
//  Created by Kévin Chassagne on 16/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var recipeNameField: UITextField!
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var channelField: UITextField!
    @IBOutlet weak var botNameField: UITextField!
    // @IBOutlet weak var imageField: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        dataSet.setObject(channelField.text, forKey: "channel")
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
        
        self.navigationController?.popToRootViewControllerAnimated(true)
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
