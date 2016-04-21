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
    var checkpoints = 10
    var currentCheckpoint = 1
    var i = 0
    
    
    var beacons = ["1319", "1234"]
    
    
    @IBOutlet weak var checkpointNumberLabel: UILabel!
    @IBOutlet weak var beaconLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var organizerField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var hint1Field: UITextView!
    @IBOutlet weak var hint2Field: UITextView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBtn.hidden = true
        nameField?.delegate = self
        organizerField?.delegate = self
        descriptionField?.delegate = self
        hint1Field?.delegate = self
        hint2Field?.delegate = self
        
        checkpointNumberLabel.text = "Checkpoint \(String(currentCheckpoint))/\(String(checkpoints))"
        beaconLabel.text = beacons[0]
        
        if currentCheckpoint == checkpoints{
            nextBtn.hidden = true
            saveBtn.hidden = false
        }
        
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
        
        let myPost = myHTTPPost()
        
        allInfo = "<checkpoint><beacon>\(beacons[i])</beacon><checkpointDescription>\(checkpointDescription)</checkpointDescription><eventID>1</eventID><hint>\(hint1)</hint><hint2>\(hint2)</hint2><imageURL>www.google.com</imageURL><name>\(checkpointName)</name><organizer>\(organizer)</organizer></checkpoint>"
        
        myPost.postData(allInfo, urlExtension: "Checkpoint")
       
        print(allInfo)
        
        currentCheckpoint+=1
        checkpointNumberLabel.text = "Checkpoint \(String(currentCheckpoint))/\(String(checkpoints))"
        //i+=1
        nameField.text = ""
        descriptionField.text = ""
        organizerField.text = ""
        hint1Field.text = ""
        hint2Field.text = ""
        allInfo = ""
        
        if currentCheckpoint == checkpoints{
            nextBtn.hidden = true
            saveBtn.hidden = false
        }
        
     
        
    }
}
