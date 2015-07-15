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

class ClassRostersController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var classRosters = [PFObject]?()
    
    var classRostersFiltered = [PFObject]()
    
    private let daysOfWeek = ["monday", "tuesday", "wednesday", "thursday", "friday"]
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "getResidents:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
        }()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var weekControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getResidents(refreshControl)
        tableView.addSubview(refreshControl)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func getResidents(refreshControl: UIRefreshControl) {
        var query = PFQuery(className:"ClassRosters")
        query.orderByAscending("name")
        query.findObjectsInBackgroundWithBlock {
            (residents: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(residents!.count) residents.")
                self.classRosters = residents?.map({$0 as! PFObject})
                self.classRostersFiltered = self.classRosters!.map({$0})
                // Do something with the found objects
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
            refreshControl.endRefreshing()
        }
    }
    
    private func doesResidentNameHaveText(resident: PFObject, searchText: String) -> Bool {
        let currentResidentName = (resident["name"] as! String).lowercaseString
        return currentResidentName.rangeOfString(searchText.lowercaseString) != nil
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            classRostersFiltered = classRosters!.map({$0})
        }
        else {
            //closure to filter
            classRostersFiltered = classRosters!.filter({self.doesResidentNameHaveText($0, searchText: searchText)})
            tableView.reloadData()
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classRostersFiltered.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("participantTableCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = classRostersFiltered[indexPath.row]["name"] as? String
        
        return cell
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if let cell = sender as? UITableViewCell {
            let i = tableView.indexPathForCell(cell)!.row
            if segue.identifier == "NameToSchedule"{
                let navigationController = segue.destinationViewController as! UINavigationController
                let personController = navigationController.topViewController as! NameOfPersonViewController
                tableView.deselectRowAtIndexPath(tableView.indexPathForCell(cell)!, animated: true)
            }
        }
        
    }
    
}
