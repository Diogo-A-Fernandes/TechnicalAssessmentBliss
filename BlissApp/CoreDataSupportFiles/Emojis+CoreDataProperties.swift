//
//  Emojis+CoreDataProperties.swift
//  BlissApp
//
//  Created by user284528 on 8/11/25.
//
//

import Foundation
import CoreData


extension Emojis {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Emojis> {
        return NSFetchRequest<Emojis>(entityName: "Emojis")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?

}

extension Emojis : Identifiable {

}
