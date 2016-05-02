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


class CheckpointParser: NSObject,NSXMLParserDelegate {
    
    var currentString = ""
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var thisCheckpoint:Checkpoint?
    
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
        managedContext = appDelegate!.managedObjectContext
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        //print("found element: \(elementName)")
        
        //Create new event object when <event> -tag is found
        if (elementName == "checkpoint") {
            print ("did start element checkpoint \(currentString)")
            thisCheckpoint = NSEntityDescription.insertNewObjectForEntityForName("Checkpoint", inManagedObjectContext: managedContext!) as? Checkpoint
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("elementName= \(elementName)")
        
        if (elementName == "checkpoint") {
            print("did end element checkpoint \(currentString)")
        } else if(elementName == "beacon") {
            thisCheckpoint?.beacon = currentString
        } else if(elementName == "checkpointDescription") {
            thisCheckpoint?.checkpointDescription = currentString
        } else if(elementName == "eventID") {
            thisCheckpoint?.eventID = NSNumber(integer: Int(currentString)!)
        } else if(elementName == "hint") {
            thisCheckpoint?.hint = currentString
        } else if(elementName == "hint2") {
            thisCheckpoint?.hint2 = currentString
        } else if(elementName == "imageURL") {
            thisCheckpoint?.imageURL = currentString
        } else if(elementName == "name") {
            thisCheckpoint?.name = currentString
        } else if(elementName == "organizer") {
            thisCheckpoint?.organizer = currentString
        }
        currentString = ""
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print ("******************************************* did end document")
        //save the parsed objects to persistent storage
        do {
            try managedContext!.save()
        } catch let error as NSError {
            print("Saving failed with error \(error), \(error.userInfo)")
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print ("Error parsing document \(parseError)")
    }
    func deleteCheckpoints() {
        //print("DELETE")
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let coord = appDel.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Checkpoint")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    

}
