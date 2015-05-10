//
//  ViewController.swift
//  Scheduling
//
//  Created by Sahith Nallapareddy on 4/22/15.
//  Copyright (c) 2015 Sahith Nallapareddy. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var residentsFiltered = [PFObject]?()
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    @IBAction func groupChosen(sender: UIButton) {
        let color = sender.currentTitle!.lowercaseString
        var query = PFQuery(className:"Residents")
        query.whereKey("color", equalTo:color)
        query.findObjectsInBackgroundWithBlock {
            (residentsFiltered, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(residentsFiltered!.count) scores.")
                
                // Do something with the found objects
                if let objects = residentsFiltered as? [PFObject] {
                    for object in objects {
                        println(object["name"]!)
                    }
                }
                self.tableView.reloadData()
                
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        self.textField.becomeFirstResponder()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        var query = PFQuery(className:"Residents")
        query.findObjectsInBackgroundWithBlock {
            (residentsFiltered, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(residentsFiltered!.count) scores.")
                // Do something with the found objects
                if let objects = residentsFiltered {
                    for object in objects {
                        println(object["name"]!)
                    }
                }
                
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
            
        }
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(100000))
        if let numberResidents = residentsFiltered {
            println(numberResidents.count)
            return numberResidents.count
        }
        else {
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let den = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        let text = residentsFiltered![indexPath.row]["name"] as! String
        let cell = den as! UITableViewCell
        cell.textLabel?.text = text
        
        return cell 
    }
    
    
}
