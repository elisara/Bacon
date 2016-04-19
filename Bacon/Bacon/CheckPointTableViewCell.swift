//
//  CheckpointTableViewCell.swift
//  Bacon
//
//  Created by iosdev on 19.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit
import Foundation

class CheckpointTableViewCell: UITableViewCell {

    @IBOutlet weak var checkpointName: UILabel!
    @IBOutlet weak var GPSLabel: UILabel!
    @IBAction func findBeacons(sender: UIButton) {
        checkpointName.text = "TestName"
        GPSLabel.text = "TestGPS"
    }
    

}
