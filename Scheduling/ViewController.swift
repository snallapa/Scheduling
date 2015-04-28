//
//  ViewController.swift
//  Scheduling
//
//  Created by Sahith Nallapareddy on 4/22/15.
//  Copyright (c) 2015 Sahith Nallapareddy. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    var residentsFiltered = [AnyObject]?()

    @IBOutlet weak var textField: UITextField!
    
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
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        [self.textField, becomeFirstResponder()]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
               // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

