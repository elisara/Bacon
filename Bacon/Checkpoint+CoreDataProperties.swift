//
//  Checkpoint+CoreDataProperties.swift
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

extension Checkpoint {

    @NSManaged var beacon: String?
    @NSManaged var checkpointDescription: String?
    @NSManaged var eventID: NSNumber?
    @NSManaged var hint: String?
    @NSManaged var hint2: String?
    @NSManaged var imageURL: String?
    @NSManaged var name: String?
    @NSManaged var organizer: String?
    @NSManaged var eventIdToCheckpoint: Event?

}
