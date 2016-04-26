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
    @IBOutlet weak var checkpointDescriptionField: UILabel!
    
    var eventID = Int()
    var managedObjectContext = NSManagedObjectContext()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        let moc = managedObjectContext
        let employeesFetch = NSFetchRequest(entityName: "Checkpoint")
        
        do {
            let fetchedEmployees = try moc.executeFetchRequest(employeesFetch) as! [Checkpoint]
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
}


