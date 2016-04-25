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
    
    //Pitää saada evnttilista eventparserilta, PYYDÄ APUA!
    
    //tätä ei enää varvita sitten kun saadaan oikea lista
    
    var events = [EventObject]()
    
    var myparser = MyHTTPGet()
    
    var fetchedResultsController: NSFetchedResultsController!
    var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view did load eventtableviewctrl")
        //loadSampleEvents()
        
        
            }
    
    override func viewWillAppear(animated: Bool) {
        //get students from the network
        myparser.httpGet()
        
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
        
        
        //tähän oikea lista sitten kun sen saa:
        //let event = events[indexPath.row]
        //print("Eventin nimi: " + event.name)
        
        //nimeksi event.getName
        let event = fetchedResultsController!.objectAtIndexPath(indexPath)
        cell.eventLabel.text = event.valueForKey("eventName") as? String
        cell.iconView.image = UIImage(named: "heart")!
        cell.eventImageView.image = UIImage(named: "blue2")!
        
        return cell
    }
    
    func loadSampleEvents()  {
    /**
        let photo1 = UIImage(named: "heart")!
        let photo2 = UIImage(named: "blue2")!
        
        let event1 = Event2(name: "Jihuu", icon: photo1, eventImage: photo2)!
        let event2 = Event2(name: "Jahuu", icon: photo1, eventImage: photo2)!
        let event3 = Event2(name: "Juhuu", icon: photo1, eventImage: photo2)!
        events += [event1, event2, event3]
        print("load samples")
        print(String(events))
 */
        
    }
    func saveContext () {
        if managedObjectContext!.hasChanges {
            do {
                try managedObjectContext!.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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
            try persistentStoreCoordinator!.executeRequest(deleteRequest, withContext: managedObjectContext!)
        } catch let error as NSError {
            debugPrint(error)
        }
        saveContext()
    }
    
    
    @IBAction func deleteEventAction(sender: UIButton) {
        deleteEvents()
    }

    
    // MARK: Navigation
    
    // In storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "selectEvent" {
            let eventDetailViewController = segue.destinationViewController as! EventViewController
            // Get the cell that generated this segue.
            if let selectedEventCell = sender as? EventTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedEventCell)!
                let selectedEvent = events[indexPath.row]
                
                eventDetailViewController.event = selectedEvent
            }
            
        }
        
    }
    

    // MARK: NSCoding
    
    func saveEvents() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: EventObject.ArchiveURL.path!)
        if !isSuccessfulSave{
            print("Failed to save events...")
        }
    }
    
    func loadEvents() -> [EventObject]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(EventObject.ArchiveURL.path!) as? [EventObject]
    }
    
    

    

}
