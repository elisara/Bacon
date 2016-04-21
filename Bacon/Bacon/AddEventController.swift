//
//  AddEventController.swift
//  Bacon
//
//  Created by iosdev on 13.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit



class AddEventController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    //var asd = myHTTPPost()
    var allInfo = ""
    var map = true
    var timer = true
    var eventName = ""
    var eventDescription = ""
    var type = ""
    var city = "jouku"
    var numberOfCheckpoints = 0
    let pickerData = [["Drinking", "Sport", "Art", "Adventure", "Sightseeing"],
                      ["Tampere","Turku","Helsinki","Oulu","Jyväskylä"]]
    
    
    //Event
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var pickTypeAndCity: UIPickerView!
    @IBOutlet weak var checkpointStepper: UIStepper!
    //@IBOutlet weak var eventDescriptionField: UITextField!
    @IBOutlet weak var eventDescriptionField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickTypeAndCity?.dataSource = self
        pickTypeAndCity?.delegate = self
        eventNameField?.delegate = self
        eventDescriptionField?.delegate = self
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        eventNameField.resignFirstResponder()
        //eventDescriptionField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        eventName = eventNameField.text!
        print("Eventname: ", eventName)
        
    }


    func textViewDidEndEditing(textView: UITextView) {
        eventDescription = eventDescriptionField.text!
        print("Eventdescription: ", eventDescription)
        
    }
    //Closes keyboard when clicking outside of the textview
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    @IBAction func stepperAction(sender: AnyObject) {
        numberLabel.text = "\(Int(checkpointStepper.value))"
        numberOfCheckpoints = Int(checkpointStepper.value)
        print("Number of checkpoint: ", numberOfCheckpoints)
    }
    
    //Timer or not
    @IBAction func timerSwitch(sender: UISwitch){
        if timer == true{
            timer = false
            print("Timer false")
        }
        else{
            timer = true
            print("Timer true")
        }
        
    }
    
    //Map or not
    @IBAction func mapSwitch(sender: UISwitch) {
        if map == true{
            map = false
            print("Map false")
        }
        else{
            map = true
            print("Map true")
        }
    }

    
    //Picking type and city
    func numberOfComponentsInPickerView(pickTypeAndCity: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickTypeAndCity: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(pickTypeAndCity: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[component][row]
    }
    
    func pickerView(pickTypeAndCity: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        type = pickerData[0][pickTypeAndCity.selectedRowInComponent(0)]
        city = pickerData[1][pickTypeAndCity.selectedRowInComponent(1)]
        print("Type: ", type, " City: ", city)
        
    }
    
    
    @IBAction func saveEvent(sender: UIButton) {
        let asd = myHTTPPost()
        
        //<?xml version=\"1.0\"encoding=\"UTF-8\"?>\n
        /*allInfo = "<event><city>\(city)</city><description>\(eventDescription)</description><eventOn>false</eventOn><ID>1</ID><imageURL>www.google.com</imageURL><map>\(String(map))</map><name>\(eventName)</name><numberOfCheckpoints>\(numberOfCheckpoints)</numberOfCheckpoints><timer>\(String(timer))</timer><type>\(type)</type></event>"
        print("Allinfo: ", allInfo)
        */
        
        allInfo = "<event><city>\(city)</city><eventDescription>\(eventDescription)</eventDescription><eventID>1</eventID><eventName>\(eventName)</eventName><eventOn>false</eventOn><imageURL>www.google.com</imageURL><map>\(map)</map><numberOfCheckpoints>\(numberOfCheckpoints)</numberOfCheckpoints><timer>\(timer)</timer><type>\(type)</type></event>"
        
        asd.postData(allInfo, urlExtension: "Event")
    }
  
}
