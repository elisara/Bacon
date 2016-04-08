//
//  EventTableViewController.swift
//  Bacon
//
//  Created by iosdev on 7.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit
/**
class EventTableViewController: UITableViewController {
    
    
    // MARK: Properties

    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleEvents()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            //Delete the row from the data source
            events.removeAtIndex(indexPath.row)
            saveEvents()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let event = events[indexPath.row]
        
        cell.eventLabel.text = event.name
        cell.iconView.image = event.icon
        cell.eventImageView.image = event.eventImage
        
        return cell
    }
    
    func loadSampleEvents(){
        let icon = UIImage(named: "siili")!
        let eventImage = UIImage(named: "blue")!
        let event1 = Event(name: "Karkkeja", icon: icon, eventImage: eventImage)!
        let event2 = Event(name: "Karkkeja", icon: icon, eventImage: eventImage)!
        let event3 = Event(name: "Karkkeja", icon: icon, eventImage: eventImage)!
        events += [event1, event2, event3]
    }
    
    /**
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EventViewController, event = sourceViewController.event{
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                events[selectedIndexPath.row] = event
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }else {
                // Add a new meal.
                let newIndexPath = NSIndexPath(forRow: events.count, inSection: 0)
                
                events.append(event)
                
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            // Save the meals.
            saveEvents()
        }
    }*/
    
     
    // MARK: Navigation
    // In storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let eventDetailViewController = segue.destinationViewController as! EventViewController
            // Get the cell that generated this segue.
            if let selectedEventCell = sender as? EventTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedEventCell)!
                let selectedEvent = events[indexPath.row]
                
                eventDetailViewController.event = selectedEvent
            }
        }
        else if segue.identifier == "AddItem"{
            print("Adding new meal")
        }
    }
    
    // MARK: NSCoding
    func saveEvents() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchiveURL.path!)
        if !isSuccessfulSave{
            print("Failed to save meals...")
        }
    }
    
    func loadEvents() -> [Event]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Event.ArchiveURL.path!) as? [Event]
    }

    
    
}
*/