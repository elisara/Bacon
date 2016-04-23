//
//  EventTableViewController.swift
//  Bacon
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
    
    //Pitää saada evnttilista eventparserilta, PYYDÄ APUA!
    
    //tätä ei enää varvita sitten kun saadaan oikea lista
    var events = [EventObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view did load eventtableviewctrl")
        //loadSampleEvents()
        
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
        return 3//events.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventTableViewCell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
        
        
        //tähän oikea lista sitten kun sen saa:
        //let event = events[indexPath.row]
        //print("Eventin nimi: " + event.name)
        
        //nimeksi event.getName
        cell.eventLabel.text = "eventti'"
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
