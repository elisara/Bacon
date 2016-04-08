//
//  Event.swift
//  Bacon
//
//  Created by iosdev on 7.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit


class Event: NSObject, NSCoding{
    
    // MARK: Properties
    
    var name: String
    var icon: UIImage?
    var eventImage: UIImage?
    
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("events")
    
    
    init?(name: String, icon: UIImage?, eventImage: UIImage?){
        
        // Initialize stored properties.
        self.name = name
        self.icon = icon
        self.eventImage = eventImage
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        
        if name.isEmpty{
            return nil
        }
    }
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let iconKey = "icon"
        static let eventImageKey = "eventImage"
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(icon, forKey:  PropertyKey.iconKey)
        aCoder.encodeObject(eventImage, forKey: PropertyKey.eventImageKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let icon = aDecoder.decodeObjectForKey(PropertyKey.iconKey) as? UIImage
        let eventImage = aDecoder.decodeObjectForKey(PropertyKey.eventImageKey) as? UIImage
        
        // Must call designated initializer.
        self.init(name: name, icon: icon, eventImage: eventImage)
    }

    
    
    

}
