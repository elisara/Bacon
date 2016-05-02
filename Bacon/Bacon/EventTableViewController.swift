
//
//  EventTableViewController.swift
//  Bacon
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit
import CoreData

class EventTableViewController: UITableViewController, NSFetchedResultsControllerDelegate{
    
    var events = [EventObject]()
    var myParser = MyHTTPGet()
    var eventParser = EventParser()
    var checkpointParser = CheckpointParser()
    
    var fetchedResultsController: NSFetchedResultsController!
    var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    var managedObjectContext: NSManagedObjectContext?
    
    @IBOutlet var eventTableView2: UITableView!
    @IBOutlet var eventTableView: UITableView!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkpointParser.deleteCheckpoints()
        myParser.httpGet("Checkpoint")
        events.removeAll()
        print("Eventslist: ", events)
        print("view did load eventtableviewctrl")
        
        
        //backbutton
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action:"back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
            }
    
    func back(sender: UIBarButtonItem) {
            let nextController = self.navigationController!.viewControllers[2] as! BrowseOrManageController
            self.navigationController?.popToViewController(nextController, animated: true)
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
    
        let appDelegate     = UIApplication.sharedApplication().delegate as! AppDelegate
        let fetchRequest    =  NSFetchRequest(entityName: "Event")
        let sortDescriptor = NSSortDescriptor(key: "eventID", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest:  fetchRequest, managedObjectContext: appDelegate.managedObjectContext, sectionNameKeyPath: nil , cacheName: nil)
        fetchedResultsController!.delegate = self
        do {
            try fetchedResultsController?.performFetch()
            
        } catch let error as NSError {
            print ("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        print("did change content")
        if valueForKey("city") != nil{
        eventTableView2.reloadData()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController!.sections![ section ].numberOfObjects

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventTableViewCell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
        
        let event = fetchedResultsController!.objectAtIndexPath(indexPath)
     
        cell.eventLabel.text = event.valueForKey("eventName") as? String
            
            if String(event.valueForKey("type")!) == "Sport"{
        cell.iconView.image = UIImage(named: "trophy")!
            }
            else if String(event.valueForKey("type")!) == "Art"{
                cell.iconView.image = UIImage(named: "paint")!
            }
            else if String(event.valueForKey("type")!) == "Sightseeing"{
                cell.iconView.image = UIImage(named: "sight")!
            }
            else if String(event.valueForKey("type")!) == "Adventure"{
                cell.iconView.image = UIImage(named: "treasure")!
            }
            else if String(event.valueForKey("type")!) == "Drinking"{
                cell.iconView.image = UIImage(named: "drinking")!
            }
            else{
                cell.iconView.image = UIImage(named: "heart")!
            }
            cell.eventImageView.image = UIImage(named: "blucell")!
        
            let object = EventObject(name: String(event.valueForKey("eventName")!), description: String(event.valueForKey("eventDescription")!), city: String(event.valueForKey("city")!), type: String(event.valueForKey("type")!), numberOfCheckpoints: (event.valueForKey("numberOfCheckpoints")?.integerValue)!, timer: (event.valueForKey("timer")?.boolValue)!, map: (event.valueForKey("map")?.boolValue)!,eventId: (event.valueForKey("eventID")?.integerValue)!,eventOn: (event.valueForKey("eventOn")?.boolValue)!)

            events.append(object!)
        
        
        return cell
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "selectEvent" {
            let destController = segue.destinationViewController as! EventViewController
            // Get the cell that generated this segue.
            if let selectedEventCell = sender as? EventTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedEventCell)!
                let selectedEvent = events[indexPath.row]
                destController.event = selectedEvent
            }
            
        }
        if segue.identifier == "addEvent" {
            let destController = segue.destinationViewController as! AddCheckpointController
            // Get the cell that generated this segue.
            if let selectedEventCell = sender as? EventTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedEventCell)!
                let selectedEvent = events[indexPath.row]
                destController.event = selectedEvent
            }
            
        }
        
    }
    
    
}
