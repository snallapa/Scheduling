//
//  ResidentTableViewCell.swift
//  Scheduling
//
//  Created by Sahith Nallapareddy on 6/1/15.
//  Copyright (c) 2015 Sahith Nallapareddy. All rights reserved.
//

import UIKit
import Parse
class ResidentTableViewCell: UITableViewCell {
    
    var resident: PFObject? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var residentName: UILabel!

    //@IBOutlet weak var residentContactPicture: UIImageView!

    
    func updateUI() {
        residentName.text = resident!["name"] as? String
        /* insert back if needed
        if(resident!["picture"] != nil) {
            let userImageFile = resident!["picture"] as! PFFile
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.residentContactPicture.image = image
                    }
                }
                else {
                    self.residentContactPicture.image = UIImage(named: "defaultContactPicture")
                }
            }
        }
        else {
            residentContactPicture.image = UIImage(named: "defaultContactPicture")
        }

        */
    }
}
