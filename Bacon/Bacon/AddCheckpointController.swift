//
//  AddCheckpointController.swift
//  Bacon
//
//  Created by iosdev on 21.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit
import CoreData



class AddCheckpointController: UIViewController, UITextFieldDelegate, UITextViewDelegate, NSFetchedResultsControllerDelegate {
    
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
    var gpsLocation = ""
    var eventId = 1
    
    var event = EventObject?()
    
    let beacons = ["1319:50423", "57832:7199"]
    
    var fetchedResultsController: NSFetchedResultsController!
    var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    var managedObjectContext: NSManagedObjectContext?
    
    let appDelegate     = UIApplication.sharedApplication().delegate as! AppDelegate
    var moc: NSManagedObjectContext?
    
    
    @IBOutlet weak var checkpointNumberLabel: UILabel!
    @IBOutlet weak var beaconLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var organizerField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var hint1Field: UITextView!
    @IBOutlet weak var hint2Field: UITextView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var GPSLocationField: UITextField!
    @IBOutlet weak var eventIdLabel: UILabel!
    @IBOutlet weak var noMoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moc = appDelegate.managedObjectContext
        saveBtn.hidden = true
        nameField?.delegate = self
        organizerField?.delegate = self
        descriptionField?.delegate = self
        hint1Field?.delegate = self
        hint2Field?.delegate = self
        GPSLocationField?.delegate = self
        noMoreLabel.hidden = true
        beaconLabel.text = beacons[i]
        
        
        
        if let event = event{
            eventIdLabel.text = String(event.eventId)
            self.eventId = event.eventId
            self.checkpoints = event.numberOfCheckpoints
            
            if currentCheckpoint == checkpoints{
                nextBtn.hidden = true
                saveBtn.hidden = false
            }
            checkpointNumberLabel.text = "Checkpoint \(String(currentCheckpoint))/\(String(checkpoints))"
        
        }
        else{
            print("Ei onnitunut")
        }
        fetchCheckpoints()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        organizerField.resignFirstResponder()
            GPSLocationField.resignFirstResponder()
        //eventDescriptionField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkpointName = nameField.text!
        print("Checkpointame: ", checkpointName)
        organizer = organizerField.text!
        print("Organizer: ", organizer)
        gpsLocation = GPSLocationField.text!
        print("GPS: ", gpsLocation)
        
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
        
        let myPost = myHTTPPost()
        
        allInfo = "<checkpoint><beacon>\(beacons[i])</beacon><checkpointDescription>\(checkpointDescription)</checkpointDescription><eventID>\(eventId)</eventID><hint>\(hint1)</hint><hint2>\(hint2)</hint2><imageURL>www.google.com</imageURL><name>\(checkpointName)</name><organizer>\(organizer)</organizer></checkpoint>"
        
        myPost.postData(allInfo, urlExtension: "Checkpoint")
       
        print(allInfo)
        
        if currentCheckpoint < checkpoints{
        currentCheckpoint+=1
        }
        checkpointNumberLabel.text = "Checkpoint \(String(currentCheckpoint))/\(String(checkpoints))"
        
        if i <= beacons.count{
        i+=1
        }
        beaconLabel.text = beacons[i]
        
        nameField.text = ""
        descriptionField.text = ""
        organizerField.text = ""
        hint1Field.text = ""
        hint2Field.text = ""
        allInfo = ""
        GPSLocationField.text = ""
        
        if currentCheckpoint == checkpoints{
            nextBtn.hidden = true
            saveBtn.hidden = false
        }
        
        
    }
    
     func fetchCheckpoints() {
        
        let checkpointsFetch = NSFetchRequest(entityName: "Checkpoint")
        print("fetchissä ", eventId)

        checkpointsFetch.predicate = NSPredicate(format: "eventID == %d", eventId)
        do {
            let fetchedCheckpoints = try moc!.executeFetchRequest(checkpointsFetch) as! [Checkpoint]
            for Checkpoint in fetchedCheckpoints {
                print("CheckpointEntityData", Checkpoint.name)
            }
            if fetchedCheckpoints.count != 0{
                noMoreLabel.hidden = false
            }

        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        
    }
    
    
    @IBAction func saveLastCheckpointAction(sender: UIButton) {
        let myPost = myHTTPPost()
        
        allInfo = "<checkpoint><beacon>\(beacons[i])</beacon><checkpointDescription>\(checkpointDescription)</checkpointDescription><eventID>\(eventId)</eventID><hint>\(hint1)</hint><hint2>\(hint2)</hint2><imageURL>www.google.com</imageURL><name>\(checkpointName)</name><organizer>\(organizer)</organizer></checkpoint>"
        
        myPost.postData(allInfo, urlExtension: "Checkpoint")
        
        print(allInfo)
        
        
    }
}
