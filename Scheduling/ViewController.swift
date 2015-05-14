//
//  ViewController.swift
//  Scheduling
//
//  Created by Sahith Nallapareddy on 4/22/15.
//  Copyright (c) 2015 Sahith Nallapareddy. All rights reserved.
//

import UIKit
import Parse
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var residentsFiltered = [PFObject]()
    var currentUserName = "Name"
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    @IBAction func groupChosen(sender: UIButton) {
        let color = sender.currentTitle!.lowercaseString
        var query = PFQuery(className:"Residents")
        query.whereKey("color", equalTo:color)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objectss = objects as? [PFObject] {
                    var i = 0

                    self.residentsFiltered = Array(objectss[0..<objectss.count])
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
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objectss = objects as? [PFObject] {
                    self.residentsFiltered = Array(objectss[0..<objectss.count])
                }
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return residentsFiltered.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let den = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! UITableViewCell
        let text = residentsFiltered[indexPath.row]["name"] as! String
        let cell = den as! UITableViewCell
        cell.textLabel?.text = text
        
        return cell 
    }
  
    
  
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
              
        if let cell = sender as? UITableViewCell {
            let i = tableView.indexPathForCell(cell)!.row
            if segue.identifier == "NameToSchedule"{
                let navigationController = segue.destinationViewController as! UINavigationController
               let personController = navigationController.topViewController as! NameOfPersonViewController
                personController.text = residentsFiltered[i]["name"] as! String
           
                personController.Schedule = residentsFiltered[i]["schedule"]
              //  println( residentsFiltered[i]["schedule"])
                
               
                
            }
        }
        
    }
    
}
