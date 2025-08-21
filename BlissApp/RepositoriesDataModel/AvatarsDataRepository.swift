//
//  AvatarsDataRepository.swift
//  BlissApp
//
//  Created by Diogo on 8/16/25.
//

import CoreData

protocol AvatarsRepository {
    func fetchDataAPIAndCreate(username: String, completionHandler: @escaping (Avatars?) -> Void)
    func getAll() -> [Avatars]
    func getAvatar(username: String) -> Avatars?
    func delete(record: Avatars) -> Bool
    func deleteAll()
}

struct AvatarsDataRepository: AvatarsRepository {
    
    private var context: NSManagedObjectContext {
        return PersistentStorage.shared.context
    }
    
    func fetchDataAPIAndCreate(username: String, completionHandler: @escaping (Avatars?) -> Void) {
        APICaller.getAvatar(username: username) { result in

            switch result {
            case .success(let data):
                self.context.perform {
                    var avatar: Avatars? = nil
                    if let existingAvatar = self.getAvatar(username: data.login) {
                        avatar = existingAvatar
                    } else {
                        avatar = Avatars(context: self.context)
                        avatar?.username = data.login.lowercased()
                        avatar?.image = data.avatarURL
                    }
                    
                    do {
                        try self.context.save()
                        print(self.getAll())
                        completionHandler(avatar)
                    } catch {
                        print("Failed to save avatar: \(error.localizedDescription)")
                        completionHandler(nil)
                    }
                }

            case .failure(let error):
                print("API failed with error: \(error.localizedDescription)")
                completionHandler(nil)
            }
        }
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

