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
    @IBOutlet weak var descriptionView: UITextView!
    
    var eventID = Int()
    var managedObjectContext = NSManagedObjectContext()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action:"back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    
    func back(sender: UIBarButtonItem) {
        let nextController = self.navigationController!.viewControllers[5] as! MapViewController
        self.navigationController?.popToViewController(nextController, animated: true)
        
        
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


