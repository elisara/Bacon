//
//  AddEventController.swift
//  Bacon
//
//  Created by iosdev on 13.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit



class AddEventController: UIViewController {
    
    
    @IBOutlet weak var eventNameField: UITextField!
    
    
    @IBOutlet weak var checkpointNumber: UILabel!
    
    @IBOutlet weak var checkpointNumberCounter: UIStepper!
    

    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBAction func timerSelector(sender: UISwitch) {
    }
    
    @IBAction func mapSelector(sender: UISwitch) {
    }
    
    
    
}
