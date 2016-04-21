//
//  Event+CoreDataProperties.swift
//  Bacon
//
//  Created by Jari Sandström on 21/04/16.
//  Copyright © 2016 iosdev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Event {

    @NSManaged var city: String?
    @NSManaged var eventDescription: String?
    @NSManaged var eventID: NSNumber?
    @NSManaged var eventName: String?
    @NSManaged var eventOn: NSNumber?
    @NSManaged var imageURL: String?
    @NSManaged var map: NSNumber?
    @NSManaged var numberOfCheckpoints: NSNumber?
    @NSManaged var timer: NSNumber?
    @NSManaged var type: String?
    @NSManaged var eventIdToCheckpoint: Checkpoint?
    @NSManaged var eventNameToScore: Score?

}
