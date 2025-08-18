//
//  AppleRepos.swift
//  BlissApp
//
//  Created by user284977 on 8/18/25.
//

import CoreData

protocol AppleRepository {
    func create(name: String) -> AppleRepos
    func getAll() -> [AppleRepos]
    func deleteAll()
}

struct AppleDataRepository: AppleRepository {
   
    private var context: NSManagedObjectContext {
        return PersistentStorage.shared.context
    }
    
    func create(name: String) -> AppleRepos {
        var newAppleRepo: AppleRepos!
        context.performAndWait {
            newAppleRepo = AppleRepos(context: context)
            newAppleRepo.name = name.lowercased()
            
            do {
                try context.save()
                print("Avatar saved: \(name)")
            } catch {
                print("Failed to save avatar: \(error.localizedDescription)")
            }
        }
        return newAppleRepo
    }
    
    func getAll() -> [AppleRepos] {
        var results: [AppleRepos] = []
        context.performAndWait {
            results = PersistentStorage.shared.fetchManagedObject(managedObject: AppleRepos.self) ?? []
        }
        return results
    }
    
    func deleteAll() {
        context.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppleRepos")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(batchDeleteRequest)
                try context.save()
                print("Deleted all avatars safely")
            } catch {
                print("Failed to delete all avatars: \(error)")
            }
        }
    }
}

