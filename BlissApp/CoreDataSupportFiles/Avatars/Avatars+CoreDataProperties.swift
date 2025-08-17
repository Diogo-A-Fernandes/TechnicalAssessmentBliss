//
//  Avatars+CoreDataProperties.swift
//  BlissApp
//
//  Created by user284977 on 8/16/25.
//
//

import Foundation
import CoreData


extension Avatars {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Avatars> {
        return NSFetchRequest<Avatars>(entityName: "Avatars")
    }

    @NSManaged public var username: String?
    @NSManaged public var image: String?

}

extension Avatars : Identifiable {

}
