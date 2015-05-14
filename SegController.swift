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

class NameOfPersonViewController: UIViewController{
    
    var text = String()

    var Schedule = AnyObject?()
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserName.text! = text
        
            let currentDate = NSDate() // You can input the custom as well
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitTimeZone, fromDate:  NSDate())
            let currentHour = (components.hour % 12)
            let currentMinute = (components.minute)
        
            println(currentHour)
            println(currentMinute)
        
        println("\(currentHour):\(currentMinute)")
        
        TimeNowLabel.text = "The time now is \(currentHour):\(currentMinute)"
       
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let dayOfWeek = dateFormatter.stringFromDate(currentDate).lowercaseString
            println(dayOfWeek)
        
        // convert strings to `NSDate` objects
      
    
        for i in 1...6 {
        let DailyStartTimes = ((Schedule![dayOfWeek]! as! NSDictionary)["event\(i)"] as! NSDictionary)["startTime"]! as! String
            
        let DailyEndTimes = ((Schedule![dayOfWeek]! as! NSDictionary)["event\(i)"] as! NSDictionary)["endTime"]! as! String
            
           println(DailyStartTimes)
            println(DailyEndTimes)
            
            
            println("check1")
            let todaysDate  = NSDate()
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.stringFromDate(todaysDate)
            
            formatter.dateFormat = formatter.dateFormat + "HH:mm"
            let DailyStartString = formatter.dateFromString(dateString + DailyStartTimes)
            let DailyEndString = formatter.dateFromString(dateString + DailyEndTimes)
            
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
                let CurrentClass = ((Schedule![dayOfWeek]! as! NSDictionary)["event\(i)"] as! NSDictionary)["name"]! as! String
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