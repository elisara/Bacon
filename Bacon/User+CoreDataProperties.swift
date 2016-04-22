//
//  User+CoreDataProperties.swift
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

extension User {

    @NSManaged var email: String?
    @NSManaged var password: String?
    @NSManaged var userName: String?
    @NSManaged var userNameToScore: Score?

}
