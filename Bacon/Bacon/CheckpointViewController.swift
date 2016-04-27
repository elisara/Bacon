//
//  CheckpointViewController.swift
//  Bacon
//
//  Created by iosdev on 26.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CheckpointViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var checkpointImageView: UIImageView!
    @IBOutlet weak var checkpointNameLabel: UILabel!
    @IBOutlet weak var checkpointOrganizerLabel: UILabel!
    @IBOutlet weak var checkpointDescriptionView: UITextView!
    
    let appDelegate     = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var eventID = Int()
    var nearestBeacon = String()
    var moc: NSManagedObjectContext?
    var visitedBeacons : [String] = []
    var numberOfCheckpoints = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moc = appDelegate.managedObjectContext
        
        //print(eventID)
        print("CheckpointViewController MAJOR:MIONR ",nearestBeacon)
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action:"back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        if !visitedBeacons.contains(nearestBeacon){
            visitedBeacons.append(nearestBeacon)
        }
        if visitedBeacons.count == numberOfCheckpoints+1{
            checkpointNameLabel.text = "Congratulations!"
        }else{
            let checkpointsFetch = NSFetchRequest(entityName: "Checkpoint")
            print(eventID)
            //let fetchRequest = NSFetchRequest()
            
            checkpointsFetch.predicate = NSPredicate(format: "eventID == %d && beacon == %@", eventID, nearestBeacon)
            
            do {
                let fetchedCheckpoints = try moc!.executeFetchRequest(checkpointsFetch) as! [Checkpoint]
                
                checkpointNameLabel.text = fetchedCheckpoints[0].name
                checkpointOrganizerLabel.text = fetchedCheckpoints[0].organizer
                checkpointDescriptionView.text = fetchedCheckpoints[0].checkpointDescription
                
                for Checkpoint in fetchedCheckpoints {
                    print("CheckpointEntityData", Checkpoint.checkpointDescription)
                }
                
                //print(checkpointsFetch)
                //print(fetchedCheckpoints[0].beacon)
            } catch {
                fatalError("Failed to fetch employees: \(error)")
            }
        }
        
    }
    
    func back(sender: UIBarButtonItem) {
        let nextController = self.navigationController!.viewControllers[5] as! MapViewController
        self.navigationController?.popToViewController(nextController, animated: true)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let DestViewController: MapViewController = segue.destinationViewController as! MapViewController
        DestViewController.eventID = eventID
        DestViewController.beaconMajorMinor = nearestBeacon
        DestViewController.visitedBeacons = visitedBeacons
    }
}