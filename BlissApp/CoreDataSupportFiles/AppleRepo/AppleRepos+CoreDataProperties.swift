//
//  AppleRepos+CoreDataProperties.swift
//  BlissApp
//
//  Created by user284977 on 8/18/25.
//
//

import Foundation
import CoreData


extension AppleRepos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppleRepos> {
        return NSFetchRequest<AppleRepos>(entityName: "AppleRepos")
    }

    @NSManaged public var name: String?

}

extension AppleRepos : Identifiable {

}
