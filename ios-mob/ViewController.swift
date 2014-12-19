//
//  ViewController.swift
//  ios-mob
//
//  Created by Jim LAURIE on 15/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit

class ViewController: SlackRequestController, UITableViewDataSource, UITableViewDelegate {
    
    var fail:Bool?
    var success:Bool?
    var tokenId = ""
    var recipeItems: NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var successMessage: UIView!
    @IBOutlet weak var failMessage: UIView!
    
    override func viewDidAppear(animated: Bool) {
        var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var itemListFromUserDefaults: NSArray? = userDefaults.objectForKey("itemList") as? NSArray
        
        if (itemListFromUserDefaults != nil) {
            recipeItems = NSMutableArray(array: itemListFromUserDefaults!)
        }
        
        self.myTableView.reloadData()
        
        // Get channels
        self.channels = []
        self.setToken(self.tokenId)
        self.getChannelList()
        
        if (self.success) != nil {
            self.successMessage.hidden = false
            UIView.animateWithDuration(1.0, animations: {
                self.successMessage.frame = CGRect(x: 0, y: 120 - 120, width: 50, height: 50)
            }, completion: { finished in
                self.updateSuccess()
            })
        }
        
        if (self.fail) != nil {
            self.failMessage.hidden = false
            UIView.animateWithDuration(1.0, animations: {
                self.successMessage.frame = CGRect(x: 0, y: 120 - 120, width: 50, height: 50)
                }, completion: { finished in
                    self.updateFail()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeItems.count
    }
    
    // List View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomCell
        let recipeItem: NSDictionary = recipeItems.objectAtIndex(indexPath.row) as NSDictionary
        
        var title = recipeItem.objectForKey("recipeName") as String
        var username = recipeItem.objectForKey("username") as String
        var message = recipeItem.objectForKey("message") as String
        var channel = recipeItem.objectForKey("channel") as String
        var botImage = "bot-ico.png"

        cell.setCell(title, messageLabel: message, channelLabel: channel, botLabel: username, botImage: botImage, index: indexPath.row)

        return cell
    }
    
    // Delete with swipe left
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            myTableView.beginUpdates()
            recipeItems.removeObjectAtIndex(indexPath.row)
            myTableView!.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            myTableView.endUpdates()
        }
    }
    
    func updateSuccess() {
        var delta: Int64 = 2 * Int64(NSEC_PER_SEC)
        var time = dispatch_time(DISPATCH_TIME_NOW, delta)
        
        dispatch_after(time, dispatch_get_main_queue(), {
            self.successMessage.hidden = true
        });
    }
    
    func updateFail() {
        var delta: Int64 = 2 * Int64(NSEC_PER_SEC)
        var time = dispatch_time(DISPATCH_TIME_NOW, delta)
        
        dispatch_after(time, dispatch_get_main_queue(), {
            self.failMessage.hidden = true
        });
    }
    
    // Cell edit button
    @IBAction func editView(sender: UIButton) {
        var item: AnyObject = recipeItems.objectAtIndex(sender.tag)
        var title = item.objectForKey("recipeName") as String
        var username = item.objectForKey("username") as String
        var message = item.objectForKey("message") as String
        var channel = item.objectForKey("channel") as String
        var botImage = "bot-ico.png"
        
        var editViewController: EditViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EditViewController") as EditViewController

        editViewController.token = self.tokenId
        editViewController.channelsList = self.channels
        editViewController.message = message
        editViewController.botname = username
        editViewController.recipeName = title
        editViewController.index = sender.tag
        
        self.navigationController?.pushViewController(editViewController, animated: true)
    }
    
    // Cell post button
    @IBAction func sendRecipe(sender: UIButton) {
        var item: AnyObject = recipeItems.objectAtIndex(sender.tag)
        
        var message = item["message"] as String
        var channel = item["channel"] as String
        var botName = item["username"] as String
        self.postMessage(channel, message: message, botName: botName)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var addViewController = segue.destinationViewController as AddViewController
        addViewController.token = self.tokenId
        addViewController.channelsList = self.channels
    }
    
}

