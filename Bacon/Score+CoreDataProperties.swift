//
//  Score+CoreDataProperties.swift
//  Bacon
//
//  Created by Jari Sandström on 22/04/16.
//  Copyright © 2016 iosdev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Score {

    @NSManaged var eventName: String?
    @NSManaged var score: NSNumber?
    @NSManaged var userName: String?
    @NSManaged var eventNameToScore: NSManagedObject?
    @NSManaged var userNameToScore: User?

}
