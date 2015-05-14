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
    
    
    @IBOutlet weak var OrangeView: UIView!
    
    @IBOutlet weak var GreenView: UIView!
    
    @IBOutlet weak var PurpleView: UIView!
    
    @IBOutlet weak var UserName: UILabel!
    
    @IBOutlet weak var ClassName: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func ScreenChanger(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            OrangeView.hidden = true
            GreenView.hidden = false
            PurpleView.hidden = true
        case 1:
            OrangeView.hidden = false
            GreenView.hidden = false
            PurpleView.hidden = true
        case 2:
            OrangeView.hidden = false
            GreenView.hidden = false
            PurpleView.hidden = false
        default:
            break;
        }
    }
    var currentUserName = "Name"
    var currentClassName = "You now have a class"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OrangeView.hidden = true
        GreenView.hidden = false
        PurpleView.hidden = true
        // Do any additional setup after loading the view.
        
        UserName.text = currentUserName

        
        
        
    }

    
}