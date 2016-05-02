//
//  Event.swift
//  Bacon
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit


class EventObject: NSObject {
    
    var name: String
    var eventDescription: String
    var city: String
    var type: String
    var numberOfCheckpoints: Int
    var timer: Bool
    var map: Bool
    var eventId: Int
    var eventOn: Bool
    
    init!(name: String!, description : String!, city: String, type: String, numberOfCheckpoints: Int, timer: Bool, map: Bool, eventId: Int, eventOn : Bool){
        
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
    
   }
