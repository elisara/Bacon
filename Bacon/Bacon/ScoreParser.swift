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


class ScoreParser: NSObject,NSXMLParserDelegate {
    
    var currentString = ""
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var thisScore:Score?
    
    func parse (xmlData:NSData) {
        let myParser = NSXMLParser(data: xmlData)
        myParser.delegate = self
        myParser.parse()
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        currentString = currentString + string
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print ("******************************************* did start document")
        appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        managedContext = appDelegate!.managedObjectContext
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        //Create new event object when <event> -tag is found
        if (elementName == "score") {
            print ("did start element score \(currentString)")
            thisScore = NSEntityDescription.insertNewObjectForEntityForName("Score", inManagedObjectContext: managedContext!) as? Score
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        if (elementName == "score") {
            print("did end element score \(currentString)")
        } else if(elementName == "eventName") {
            thisScore?.eventName = currentString
        } else if(elementName == "score") {
            thisScore?.score = NSNumber(integer: Int(currentString)!)
        } else if(elementName == "userName") {
            thisScore?.userName = currentString
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
}
