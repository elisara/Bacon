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
    var moc: NSManagedObjectContext?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moc = appDelegate.managedObjectContext
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action:"back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    
    func back(sender: UIBarButtonItem) {
        let nextController = self.navigationController!.viewControllers[5] as! MapViewController
        self.navigationController?.popToViewController(nextController, animated: true)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let checkpointsFetch = NSFetchRequest(entityName: "Checkpoint")
        print(eventID)
        //let fetchRequest = NSFetchRequest()
        
        checkpointsFetch.predicate = NSPredicate(format: "eventID == %d", eventID)
        do {
            let fetchedCheckpoints = try moc!.executeFetchRequest(checkpointsFetch) as! [Checkpoint]
            
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


