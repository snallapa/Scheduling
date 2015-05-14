//
//  TodayTableViewCell.swift
//  Scheduling
//
//  Created by Sahith Nallapareddy on 5/14/15.
//  Copyright (c) 2015 Sahith Nallapareddy. All rights reserved.
//

import UIKit

class TodayTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var eventNameLabel: UILabel!
    
    var event: NSDictionary? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let timeEvent = event {
            eventNameLabel.text = timeEvent["name"]
            let startTime = timeEvent["startTime"]
            let endTime = timeEvent["endTime"]
            timeLabel.text = ("\(startTime):\(endTime)")
        }
        
    }
}
