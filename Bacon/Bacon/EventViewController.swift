//
//  EventViewController.swift
//  Bacon
//
//  Created by iosdev on 13.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EventViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    
    
    @IBOutlet weak var blockLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    var moc: NSManagedObjectContext?
    let appDelegate     = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    var event = EventObject?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moc = appDelegate.managedObjectContext
        
        testIfCheckpoints()
  
        eventNameLabel.text! = event!.name
    
        if event!.type == "Sport"{
            iconView.image = UIImage(named: "trophy")!
        }
        else if event!.type == "Art"{
            iconView.image = UIImage(named: "paint")!
        }
        else if event!.type == "Sightseeing"{
            iconView.image = UIImage(named: "sight")!
        }
        else if event!.type == "Adventure"{
            iconView.image = UIImage(named: "treasure")!
        }
        else if event!.type == "Drinking"{
            iconView.image = UIImage(named: "drinking")!
        }
        else{
            iconView.image = UIImage(named: "heart")!
        }
        
        eventImageView.image = UIImage(named: "blue3")!
        descriptionView.text! = event!.eventDescription
        
        print(event!.name)
        print(event!.eventDescription)
        
       
        print("EventViewController: ", event?.eventId)
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action:"back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    
    func back(sender: UIBarButtonItem) {
        let nextController = self.navigationController!.viewControllers[3] as! EventTableViewController
        self.navigationController?.popToViewController(nextController, animated: true)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let DestViewController: MapViewController = segue.destinationViewController as! MapViewController
        DestViewController.eventID = (event?.eventId)!
        DestViewController.numberOfCheckpoints = (event?.numberOfCheckpoints)!
    }
    
    func testIfCheckpoints(){
        let checkpointsFetch = NSFetchRequest(entityName: "Checkpoint")
       
        //let fetchRequest = NSFetchRequest()
        
        checkpointsFetch.predicate = NSPredicate(format: "eventID == %d", (event?.eventId)!)
        
        do {
            let fetchedCheckpoints = try moc!.executeFetchRequest(checkpointsFetch) as! [Checkpoint]
            
            if fetchedCheckpoints.count == 0{
                startBtn.enabled = false
                blockLabel.hidden = false
            }
            else{
                startBtn.enabled = true
                blockLabel.hidden = true
            }
        
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        
    }
    
    
    @IBAction func startButton(sender: UIButton) {
    }
    
}


