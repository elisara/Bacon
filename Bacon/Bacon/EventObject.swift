//
//  Event.swift
//  Bacon
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit


class EventObject: NSObject, NSCoding{
    
    // MARK: Properties
    
    var name: String
    var eventDescription: String
    var city: String
    var type: String
    var numberOfCheckpoints: Int
    var timer: Bool
    var map: Bool
    var eventId: Int
    var eventOn: Bool
    
    
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("events")
    
    
    init?(name: String, description : String, city: String, type: String, numberOfCheckpoints: Int, timer: Bool, map: Bool, eventId: Int, eventOn : Bool){
        
        // Initialize stored properties.
        self.name = name
        self.eventDescription = description
        self.city = city
        self.type = type
        self.numberOfCheckpoints = numberOfCheckpoints
        self.timer = timer
        self.map = map
        self.eventId = eventId
        self.eventOn = eventOn
        
        super.init()
        
    }
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let descriptionKey = "eventDescription"
        static let cityKey = "city"
        static let typeKey = "type"
        static let numberOfCheckpointsKey = "numberOfCheckpoints"
        static let timerKey = "timer"
        static let mapKey = "map"
        static let eventIdKey = "eventId"
        static let eventOnKey = "eventOn"
    }
    
    // MARK: NSCoding
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(eventDescription, forKey: PropertyKey.descriptionKey)
        aCoder.encodeObject(city, forKey: PropertyKey.cityKey)
        aCoder.encodeObject(type, forKey: PropertyKey.typeKey)
        aCoder.encodeObject(numberOfCheckpoints, forKey: PropertyKey.numberOfCheckpointsKey)
        aCoder.encodeObject(timer, forKey: PropertyKey.timerKey)
        aCoder.encodeObject(map, forKey: PropertyKey.mapKey)
        aCoder.encodeObject(eventId, forKey: PropertyKey.eventIdKey)
        aCoder.encodeObject(eventOn, forKey: PropertyKey.eventOnKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let eventDescription = aDecoder.decodeObjectForKey(PropertyKey.descriptionKey) as! String
        let city = aDecoder.decodeObjectForKey(PropertyKey.cityKey) as! String
        let type = aDecoder.decodeObjectForKey(PropertyKey.typeKey) as! String
        let numberOfCheckpoints = aDecoder.decodeObjectForKey(PropertyKey.numberOfCheckpointsKey) as! Int
        let timer = aDecoder.decodeObjectForKey(PropertyKey.timerKey) as! Bool
        let map = aDecoder.decodeObjectForKey(PropertyKey.mapKey) as! Bool
        let eventId = aDecoder.decodeObjectForKey(PropertyKey.eventIdKey) as! Int
        let eventOn = aDecoder.decodeObjectForKey(PropertyKey.eventOnKey) as! Bool
        
        
        // Must call designated initializer.
        self.init(name: name, description: eventDescription, city: city, type: type, numberOfCheckpoints: numberOfCheckpoints, timer: timer, map: map, eventId: eventId, eventOn: eventOn)
    }
    
    func getAll() -> (String, String, String, String, Int, Bool, Bool, Int, Bool){
        return(name, eventDescription, city, type, numberOfCheckpoints, timer, map, eventId, eventOn)
    }
    
    func getEventName() -> String{
        return name
    }
    
}
