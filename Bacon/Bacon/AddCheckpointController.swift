//
//  AddCheckpointController.swift
//  Bacon
//
//  Created by iosdev on 21.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit


class AddCheckpointController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var allInfo = ""
    var checkpointNumber = 1
    var beacon = ""
    var checkpointName = ""
    var organizer = ""
    var checkpointDescription = ""
    var hint1 = ""
    var hint2 = ""
    
    
    var beacons = ["1319", "1234"]
    
    
    @IBOutlet weak var checkpointNumberLabel: UILabel!
    @IBOutlet weak var beaconLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var organizerField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var hint1Field: UITextView!
    @IBOutlet weak var hint2Field: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        nameField?.delegate = self
        organizerField?.delegate = self
        descriptionField?.delegate = self
        hint1Field?.delegate = self
        hint2Field?.delegate = self
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        organizerField.resignFirstResponder()
        //eventDescriptionField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkpointName = nameField.text!
        print("Checkpointame: ", checkpointName)
        organizer = organizerField.text!
        print("Organizer: ", organizer)
        
    }
    
    
    func textViewDidEndEditing(textView: UITextView) {
        checkpointDescription = descriptionField.text!
        print("Checkpoint description: ", checkpointDescription)
        hint1 = hint1Field.text!
        print("Hint1 : ", hint1)
        hint2 = hint2Field.text!
        print("Hint2: ", hint2)
        
    }
    //Closes keyboard when clicking outside of the textview
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    
    @IBAction func saveCheckpoint(sender: UIButton) {
        //<?xml version=\"1.0\"encoding=\"UTF-8\"?>\n
        
        allInfo = "<checkpoint><beacon>\(beacons[0])</beacon><checkpointDescription>\(checkpointDescription)</checkpointDescription><eventID>1</eventID><hint>\(hint1)</hint><hint2>\(hint2)</hint2><imageURL>www.google.com</imageURL><name>\(checkpointName)</name><organizer>\(organizer)</organizer></checkpoint>"
       
        print(allInfo)
        
        
    }
}
