//
//  SegmentedViewController.swift
//  Scheduling
//
//  Created by Jagath Jai Kumar on 5/5/15.
//  Copyright (c) 2015 Sahith Nallapareddy. All rights reserved.
//

import Foundation
import UIKit

class NameOfPersonViewController:UIViewController {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var scheduleView: UIView!
    
    @IBAction func changeSchedule(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            println("Hello")
        default:
            break; 
        }
        
    }
    
    
}