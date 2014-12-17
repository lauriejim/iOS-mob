//
//  ViewController.swift
//  ios-mob
//
//  Created by Jim LAURIE on 15/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
//  var arrayOfRecipes: [Recipe] = [Recipe]()
    var recipeItems: NSMutableArray = NSMutableArray()
    
    override func viewDidAppear(animated: Bool) {
        var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var itemListFromUserDefaults: NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        
        if (itemListFromUserDefaults != nil) {
            recipeItems = itemListFromUserDefaults!
        }
        
        self.myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
//        self.setUpRecipes()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Add Recipes
//    func setUpRecipes(){
//        var recipe1 = Recipe(recipeName: "Arrived at Hétic", username: "Bobneick", message: "Hi boys. I'm Tina. Hey Jimmy Jr.", channel: "#test", imageName: "http://lorempixel.com/48/48")
//        var recipe2 = Recipe(recipeName: "Want a burger", username: "Bobneick", message: "Hi boys. I'm hungry.", channel: "#test", imageName: "http://lorempixel.com/48/48")
//        
//        arrayOfRecipes.append(recipe1)
//        arrayOfRecipes.append(recipe2)
//        arrayOfRecipes.append(recipe1)
//        arrayOfRecipes.append(recipe2)
//        arrayOfRecipes.append(recipe1)
//        arrayOfRecipes.append(recipe2)
//        arrayOfRecipes.append(recipe1)
//        arrayOfRecipes.append(recipe2)
//        
//    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeItems.count
    }
    
    // List View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomCell
//        let recipe = arrayOfRecipes[indexPath.row]
//        
//        cell.setCell(recipe.recipeName, messageLabel: recipe.message, channelLabel: recipe.channel, botLabel: recipe.username, botImageView: recipe.imageName)

        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomCell
        let recipeItem: NSDictionary = recipeItems.objectAtIndex(indexPath.row) as NSDictionary
        
        cell.setCell(recipeItem.objectForKey("recipeName") as String, messageLabel: recipeItem.objectForKey("message") as String, channelLabel: recipeItem.objectForKey("channel") as String, botLabel: recipeItem.objectForKey("username") as String, index: indexPath.row)

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
        
        SlackRequestController().postMessage("#" + channel, message: message, botName: botName)
        
    }
    
//    @IBAction func postRecipe(sender: AnyObject) {
//        let alert = UIAlertController(title: "Post", message: "Message envoyé!", preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
//        self.presentViewController(alert, animated: true, completion: nil)
//        
//        println("post")
//    }
    
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
    
}

