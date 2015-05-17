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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var residentsNames = [String]()
    
    var residentsFiltered = [PFObject]() {
        didSet {
            resetNames()
        }
    }
    
    var currentUserName = "Name"
    
    
    @IBOutlet weak var userSearchField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var residentName = "" {
        didSet{
            updateTableView()
        }
    }
    
    
    
    
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

                    self.residentsFiltered = Array(objectss[0..<objectss.count])
                }
                self.tableView.reloadData()
                
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        self.userSearchField.becomeFirstResponder()
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
        userSearchField.delegate = self
    }
    
    func updateTableView() {
        for var i = 0; i<residentsNames.count;++i {
            if(residentsNames[i].lowercaseString.rangeOfString(residentName) == nil) {
                residentsNames.removeAtIndex(i)
                --i
            }
        }
        tableView.reloadData()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == userSearchField {
            resetNames()
            if(string.isEmpty) {
                residentName = residentName.substringToIndex(advance(residentName.startIndex, count(residentName) - 1))
            }
            residentName += string
            
        }
        return true
    }
    
    func resetNames() {
        residentsNames.removeAll()
        for i in 0..<residentsFiltered.count {
            residentsNames.append(residentsFiltered[i]["name"] as! String)
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

        return residentsNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! UITableViewCell
        let text = residentsNames[indexPath.row]
        cell.textLabel?.text = text
        
        return cell 
    }
  
    
    func getScheduleFromName(name: String) -> Int{
        for i in 0..<residentsFiltered.count {
            if(residentsFiltered[i]["name"] as! String == name) {
                return i
            }
        }
        return -1
    }
    
  
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
              
        if let cell = sender as? UITableViewCell {
            let i = tableView.indexPathForCell(cell)!.row
            if segue.identifier == "NameToSchedule"{
                let navigationController = segue.destinationViewController as! UINavigationController
                let personController = navigationController.topViewController as! NameOfPersonViewController
                personController.text = residentsNames[i]
                println("\(getScheduleFromName(residentsNames[i]))")
             //   println(residentsFiltered[getScheduleFromName(residentsNames[i])]["schedule"])
                personController.Schedule = residentsFiltered[getScheduleFromName(residentsNames[i])]["schedule"]!
                tableView.deselectRowAtIndexPath(tableView.indexPathForCell(cell)!, animated: true)
                
                
               
                
            }
        }
        
    }
    
}
