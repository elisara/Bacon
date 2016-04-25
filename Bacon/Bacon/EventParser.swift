//
//  EventParser.swift
//  Bacon
//
//  Created by Jari Sandström on 21/04/16.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class EventParser: NSObject, NSXMLParserDelegate {
    
    var currentString = ""
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var thisEvent:Event?
    
    //var eventList = [EventObject]()
    
    
    
    func parse (xmlData:NSData) {
        let myParser = NSXMLParser(data: xmlData)
        myParser.delegate = self
        myParser.parse()
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        //print ("found characters: \(string)")
        currentString = string
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print ("******************************************* did start document")
        appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        print ("******************************************* did start AppDelegate")
        managedContext = appDelegate!.managedObjectContext
        print ("******************************************* did start managedContext")
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        print("found element: \(elementName)")
        
        //Create new event object when <event> -tag is found
        if (elementName == "events") {
            print ("did start element event \(currentString)")
            thisEvent = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: managedContext!) as? Event
                }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("elementName= \(elementName)")
        
        if (elementName == "events") {
            print("did end element event \(currentString)")
            
           /** let object = EventObject(name: thisEvent!.eventName!, description: thisEvent!.eventDescription!, city: thisEvent!.city!, type: thisEvent!.type!, numberOfCheckpoints: Int(thisEvent!.numberOfCheckpoints!), timer: Bool(thisEvent!.timer!), map: Bool(thisEvent!.map!),eventId: Int(thisEvent!.eventID!),eventOn: Bool(thisEvent!.eventOn!))
            
            print("Object created in eventparser: ", String(object))
            
            eventList.append(object!)
            print("Getall test: ", object?.getAll())
            */
            
        } else if(elementName == "eventName") {
            thisEvent?.eventName = currentString
            print("EVENTTINIMI: ",String(currentString))
        } else if (elementName == "eventDescription") {
            thisEvent?.eventDescription = currentString
            print(thisEvent?.eventDescription)
        } else if (elementName == "city") {
            thisEvent?.city = currentString
            print(currentString)
        } else if (elementName == "eventID") {
            thisEvent?.eventID = NSNumber(integer: Int(currentString)!)
        } else if (elementName == "eventOn") {
            if currentString == "true"{
                thisEvent?.eventOn = 1
            } else{
                thisEvent?.eventOn = 0
            }
        } else if (elementName == "imageURL") {
            thisEvent?.imageURL = currentString
        } else if (elementName == "map") {
            if currentString == "true"{
                thisEvent?.map = 1
            } else{
                thisEvent?.map = 0
            }
        } else if (elementName == "numberOfCheckpoints") {
            thisEvent?.numberOfCheckpoints = NSNumber(integer: Int(currentString)!)
        } else if (elementName == "timer") {
            if currentString == "true"{
                thisEvent?.timer = 1
            } else{
                thisEvent?.timer = 0
            }
        } else if (elementName == "type") {
            thisEvent?.type = currentString
            
        }
            print("This event: ", String(thisEvent))
    }
    
    
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print ("******************************************* did end document")
        //save the parsed objects to persistent storage
        do {
            try managedContext!.save()
           // print(String(eventList))
            
        } catch let error as NSError {
            print("Saving failed with error \(error), \(error.userInfo)")
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print ("Error parsing document \(parseError)")
    }
    
    /**
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let DestViewController : EventTableViewController = segue.destinationViewController as! EventTableViewController
        DestViewController.testi = String(eventList[0])
        print("Segue list0: ", String(eventList[0]))
        
    }*/
    
    
}
