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


class UserParser: NSObject,NSXMLParserDelegate {
    
    var currentString = ""
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var thisUser:User?
    
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
        //Create new event object when <event> -tag is found
        if (elementName == "user") {
            print ("did start element user \(currentString)")
            thisUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedContext!) as? User
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        if (elementName == "user") {
            print("did end element user \(currentString)")
        } else if(elementName == "email") {
            thisUser?.email = currentString
        } else if(elementName == "password") {
            thisUser?.password = currentString
        } else if(elementName == "userName") {
            thisUser?.userName = currentString
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
    func deleteUsers() {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let coord = appDel.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    

}
