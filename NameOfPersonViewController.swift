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

    var Schedule: AnyObject? = AnyObject?()
    
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
        
        
        
        if (dayOfWeek != "sunday" && dayOfWeek != "saturday"){
        let currentEvent = ((Schedule![dayOfWeek]! as! NSDictionary)["event\(indexPath.row + 1)"] as! NSDictionary)
        
        
        
        cell.event = currentEvent
        }
        else {
        
        cell.event = nil
        }
        
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
    
        println(dayOfWeek!)
        
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
        
        
        var currentClassIndex = -1
    
        
        if (dayOfWeek! != "sunday" && dayOfWeek! != "saturday"){
        for i in 1...6 {
            let dailyStartTimes = ((Schedule![dayOfWeek!]! as! NSDictionary)["event\(i)"] as! NSDictionary)["startTime"]! as! String
            
            let dailyEndTimes = ((Schedule![dayOfWeek!]! as! NSDictionary)["event\(i)"] as! NSDictionary)["endTime"]! as! String
            
            println(dailyStartTimes)
            println(dailyEndTimes)
            
            let hourStart = dailyStartTimes.substringWithRange(Range<String.Index>(start: dailyStartTimes.startIndex, end: dailyStartTimes.rangeOfString(":")!.startIndex))
            let minStart = dailyStartTimes.substringWithRange(Range<String.Index>(start: advance(dailyStartTimes.rangeOfString(":")!.startIndex,1), end: dailyStartTimes.endIndex))
            if(currentHour == hourStart.toInt()) {
                if (currentMinute > minStart.toInt()) {
                    currentClassIndex = i
                }
                else {
                    if(i == 0) {
                        currentClassIndex = -1
                    }
                    else {
                        currentClassIndex = i-1
                    }
                    
                }
            }
            }
            
            RoomNumber.text = ""
            if (dayOfWeek! == "sunday" || dayOfWeek! == "saturday"){
                ClassName.text = "You do not have class today"
            }
            
            if(currentClassIndex == -1) {
                ClassName.text = "You do not have class today"
            }
            else {
        
                let classText = ((Schedule![dayOfWeek!]! as! NSDictionary)["event\(currentClassIndex)"] as! NSDictionary)["name"]! as! String
                if(classText.isEmpty) {
                    ClassName.text = "You have no classes right now"
                }
                else {
                    ClassName.text = "You have \(classText) right now"
                }

                
            }
            
            
            
        }
        OrangeView.hidden = true
        GreenView.hidden = false
        
        // Do any additional setup after loading the view.
        
   //     UserName.text = currentUserName
            
    }
    


    
}