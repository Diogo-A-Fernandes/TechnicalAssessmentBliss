//
//  AvatarsDataRepository.swift
//  BlissApp
//
//  Created by Diogo on 8/16/25.
//

import CoreData

protocol AvatarsRepository {
    func create(username: String, image: String) -> Avatars
    func getAll() -> [Avatars]
    func getAvatar(username: String) -> Avatars?
    func delete(record: Avatars) -> Bool
    func deleteAll()
}

struct AvatarsDataRepository: AvatarsRepository {
    
    private var context: NSManagedObjectContext {
        return PersistentStorage.shared.context
    }
    
    func create(username: String, image: String) -> Avatars {
        var newAvatar: Avatars!
        context.performAndWait {
            newAvatar = Avatars(context: context)
            newAvatar.username = username.lowercased()
            newAvatar.image = image
            
            do {
                try context.save()
                print("Avatar saved: \(username)")
            } catch {
                print("Failed to save avatar: \(error.localizedDescription)")
            }
        }
        return newAvatar
    }
    
    
    func getAll() -> [Avatars] {
        var results: [Avatars] = []
        context.performAndWait {
            results = PersistentStorage.shared.fetchManagedObject(managedObject: Avatars.self) ?? []
        }
        return results
    }
    
    func getAvatar(username: String) -> Avatars? {
        var result: Avatars?
        context.performAndWait {
            let fetchRequest: NSFetchRequest<Avatars> = Avatars.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "username == %@", username.lowercased())
            fetchRequest.fetchLimit = 1
            do {
                result = try context.fetch(fetchRequest).first
            } catch {
                print("Failed to fetch avatar: \(error)")
            }
        }
        return result
    }
    
    func delete(record: Avatars) -> Bool {
        var success = false
        context.performAndWait {
            context.delete(record)
            do {
                try context.save()
                success = true
            } catch {
                print("Failed to delete avatar: \(error)")
                success = false
            }
        }
        return success
    }
    
    func deleteAll() {
        context.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Avatars")
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

