//
//  SegController.swift
//  Scheduling
//
//  Created by Jagath Jai Kumar on 5/9/15.
//  Copyright (c) 2015 Sahith Nallapareddy. All rights reserved.
//

import Foundation
import UIKit
import Parse

class NameOfPersonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var text = String()

    var Schedule = AnyObject?()
    
    var currentDate = NSDate()
    
    var dayOfWeek: String?
    
    @IBOutlet weak var OrangeView: UIView!
    
    @IBOutlet weak var GreenView: UIView!
   
    @IBOutlet weak var UserName: UILabel!
    
    @IBOutlet weak var ClassName: UILabel!
    
    @IBOutlet weak var RoomNumber: UILabel!
    
    @IBOutlet weak var DailyScheduleTableView: UITableView!
    
    @IBOutlet weak var TimeNowLabel: UILabel!

    

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func ScreenChanger(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            OrangeView.hidden = true
            GreenView.hidden = false
            
        case 1:
            OrangeView.hidden = false
            GreenView.hidden = false
            
        case 2:
            OrangeView.hidden = false
            GreenView.hidden = false
            
        default:
            break;
        }
    }
   
    
    
    var currentClassName = ""
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.stringFromDate(currentDate).lowercaseString

        let cell = tableView.dequeueReusableCellWithIdentifier("DailyClassEvent", forIndexPath: indexPath) as! TodayTableViewCell
        
       // if (((Schedule![dayOfWeek]! as! NSDictionary)["event\(indexPath.row + 1)"] as! NSDictionary)["name"]! as! String != ""){
        let currentEvent = ((Schedule![dayOfWeek]! as! NSDictionary)["event\(indexPath.row + 1)"] as! NSDictionary)
        cell.event = currentEvent
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DailyScheduleTableView.delegate = self
        DailyScheduleTableView.dataSource = self
        
        
        currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dayOfWeek = dateFormatter.stringFromDate(currentDate).lowercaseString
    
        
        UserName.text! = text
        
            // You can input the custom as well
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitTimeZone, fromDate:  NSDate())
        let currentHour = (components.hour % 12)
        let currentMinute = (components.minute)
        
            println(currentHour)
            println(currentMinute)
        
        println("\(currentHour):\(currentMinute)")
        
        if(currentMinute<10) {
            TimeNowLabel.text = "The time now is \(currentHour):0\(currentMinute)"
        }
        else {
            TimeNowLabel.text = "The time now is \(currentHour):\(currentMinute)"
        }
        
        
        // convert strings to `NSDate` objects
        
        
      
    
        for i in 1...6 {
            let dailyStartTimes = ((Schedule![dayOfWeek!]! as! NSDictionary)["event\(i)"] as! NSDictionary)["startTime"]! as! String
            
            let dailyEndTimes = ((Schedule![dayOfWeek!]! as! NSDictionary)["event\(i)"] as! NSDictionary)["endTime"]! as! String
            
            println(dailyStartTimes)
            println(dailyEndTimes)
            
            
            println("check1")
            let todaysDate  = NSDate()
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.stringFromDate(todaysDate)
            
            formatter.dateFormat = formatter.dateFormat + "HH:mm"
            let DailyStartString = formatter.dateFromString(dateString + dailyStartTimes)
            let DailyEndString = formatter.dateFromString(dateString + dailyEndTimes)
            
            // now we can see if today's date is inbetween these two resulting `NSDate` objects
            println(DailyStartString)
            println(DailyEndString)
            
            let testString = formatter.dateFromString(dateString + "7:00")
            let testString2 = formatter.dateFromString(dateString + "8:00")

            println("today is \(todaysDate)")
            println("test string is \(testString)")
            
            
            let isInRange = todaysDate.compare(DailyStartString!) != .OrderedAscending && todaysDate.compare(DailyEndString!) != .OrderedDescending
            
            let isInRange2 = todaysDate.compare(testString!) != .OrderedAscending && todaysDate.compare(testString2!) != .OrderedDescending
            
            
            println(isInRange)
            println("second test \(isInRange)")
          
            if (isInRange == false){
                currentClassName = "You do not have a class right now"
                ClassName.text = currentClassName
                RoomNumber.text = ""
            
            }
            if (isInRange == true){
                let CurrentClass = ((Schedule![dayOfWeek!]! as! NSDictionary)["event\(i)"] as! NSDictionary)["name"]! as! String
                currentClassName = "You have \(CurrentClass) right now"
                ClassName.text = currentClassName
                
                RoomNumber.text = "Please attend your class now"

        
            }
            
            
            
        }
        
        
        
        
        
        
        
        OrangeView.hidden = true
        GreenView.hidden = false
        
        // Do any additional setup after loading the view.
        
   //     UserName.text = currentUserName
            
    }
    


    
}