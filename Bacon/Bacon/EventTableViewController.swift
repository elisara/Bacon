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
    var myparser = MyHTTPGet()
    var eventParser = EventParser()
    
    var fetchedResultsController: NSFetchedResultsController!
    var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        events.removeAll()
        print("Eventslist: ", events)
        print("view did load eventtableviewctrl")
        //loadSampleEvents()
        //myparser.httpGet()
        
            }
    
    override func viewWillAppear(animated: Bool) {
        //get students from the network
    
        //set up fetched results controller for the tableview
        let appDelegate     = UIApplication.sharedApplication().delegate as! AppDelegate
        let fetchRequest    =  NSFetchRequest(entityName: "Event")
        let sortDescriptor = NSSortDescriptor(key: "eventName", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        

        
        fetchedResultsController = NSFetchedResultsController(fetchRequest:  fetchRequest, managedObjectContext: appDelegate.managedObjectContext, sectionNameKeyPath: nil , cacheName: nil)
        fetchedResultsController!.delegate = self
        do {
            try fetchedResultsController?.performFetch()
            
        } catch let error as NSError {
            print ("Could not fetch \(error), \(error.userInfo)")
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
        
        //if (event.valueForKey("eventID")?.integerValue) != events[0].eventId{
        cell.eventLabel.text = event.valueForKey("eventName") as? String
        cell.iconView.image = UIImage(named: "heart")!
        cell.eventImageView.image = UIImage(named: "blue2")!
        
            let object = EventObject(name: String(event.valueForKey("eventName")!), description: String(event.valueForKey("eventDescription")!), city: String(event.valueForKey("city")!), type: String(event.valueForKey("type")!), numberOfCheckpoints: (event.valueForKey("numberOfCheckpoints")?.integerValue)!, timer: (event.valueForKey("timer")?.boolValue)!, map: (event.valueForKey("map")?.boolValue)!,eventId: (event.valueForKey("eventID")?.integerValue)!,eventOn: (event.valueForKey("eventOn")?.boolValue)!)

            events.append(object!)
        //}
        
        return cell
    }
    
    func saveContext () {
        if managedObjectContext!.hasChanges {
            do {
                try managedObjectContext!.save()
            } catch {
               
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func deleteEvents() {
        let fetchRequest = NSFetchRequest(entityName: "Event")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentStoreCoordinator.executeRequest(deleteRequest, withContext: managedObjectContext!)
        } catch let error as NSError {
            debugPrint(error)
        }
        saveContext()
    }
    
    
    @IBAction func deleteEventAction(sender: UIButton) {
        //deleteEvents()
        eventParser.deleteEvents()
    }

    
    // MARK: Navigation
    
    // In storyboard-based application, you will often want to do a little preparation before navigation
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
        
    }
    

    // MARK: NSCoding
    
    func saveEvents() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: EventObject.ArchiveURL.path!)
        print("")
        if !isSuccessfulSave{
            print("Failed to save events...")
        }
    }
    
    func loadEvents() -> [EventObject]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(EventObject.ArchiveURL.path!) as? [EventObject]
    }

}
