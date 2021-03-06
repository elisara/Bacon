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
    var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    
    func parse (xmlData:NSData) {
        let myParser = NSXMLParser(data: xmlData)
        myParser.delegate = self
        myParser.parse()
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        //print ("found characters: \(string)")
        currentString = currentString + string
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
        if (elementName == "event") {
            print ("did start element event \(currentString)")
            thisEvent = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: managedContext!) as? Event
                }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("elementName= \(elementName)")
        
        if (elementName == "events") {
            print("did end element event \(currentString)")
            if (thisEvent?.eventID == currentString){
                print("sama ID")
            }
        } else if(elementName == "eventName") {
            thisEvent?.eventName = currentString
        } else if (elementName == "eventDescription") {
            thisEvent?.eventDescription = currentString
        } else if (elementName == "city") {
            thisEvent?.city = currentString
        }  else if (elementName == "eventOn") {
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
            
        }else if (elementName == "eventID") {
            thisEvent?.eventID = NSNumber(integer: Int(currentString)!)
            print("EventID: ", currentString)
        }
        currentString = ""
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

    
    func deleteEvents() {
        print("DELETE")
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let coord = appDel.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Event")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    
}
