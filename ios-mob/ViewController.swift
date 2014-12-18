//
//  ViewController.swift
//  ios-mob
//
//  Created by Jim LAURIE on 15/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit

class ViewController: SlackRequestController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var recipeItems: NSMutableArray = NSMutableArray()
    var tokenId = ""
    
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

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        // self.setUpRecipes()
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
    
    // Cell edit button
    @IBAction func editRecipe(sender: UIButton) {
        println("Edit")
    }
    
    // Cell post button
    @IBAction func sendRecipe(sender: UIButton) {
        var item: AnyObject = recipeItems.objectAtIndex(sender.tag)
        
        var message = item["message"] as String
        var channel = item["channel"] as String
        var botName = item["username"] as String
        
        self.postMessage(channel, message: message, botName: botName)
        
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
    
    // Detail view
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let recipe = arrayOfRecipes[indexPath.row]
//        
//        var detailedViewController: DetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as DetailViewController
//        detailedViewController.titleString = recipe.recipeName
//        detailedViewController.messageString = recipe.message
//        detailedViewController.usernameString = recipe.username
//        detailedViewController.channelString = recipe.channel
//        detailedViewController.imageString = recipe.imageName
//        
//        self.presentViewController(detailedViewController, animated: true, completion: nil)
//        
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var addViewController = segue.destinationViewController as AddViewController
        addViewController.token = self.tokenId
        addViewController.channelsList = self.channels
    }
    
}

