//
//  EmojisDataRepository.swift
//  BlissApp
//
//  Created by Diogo on 8/9/25.
//

import CoreData

protocol EmojisRepository {
    func create(name: String, image: String)
    func getAll() -> [Emojis]
    func getEmoji(name: String) -> Emojis?
    func getRandomEmoji() -> Emojis?
    func update(emoji: Emojis) -> Bool
    func delete(record: Emojis) -> Bool
    func deleteAllEmojis()
}

struct EmojisDataRepository: EmojisRepository {
    
    private var context: NSManagedObjectContext {
        return PersistentStorage.shared.context
    }
    
    func create(name: String, image: String) {
        context.perform {
            let newEmoji = Emojis(context: context)
            newEmoji.name = name
            newEmoji.image = image
            
            do {
                try context.save()
                print("Emoji saved: \(name)")
            } catch {
                print("Failed to save emoji: \(error.localizedDescription)")
            }
        }
    }
    
    func getAll() -> [Emojis] {
        var results: [Emojis] = []
        context.performAndWait {
            results = PersistentStorage.shared.fetchManagedObject(managedObject: Emojis.self) ?? []
        }
        return results
    }
    
    func getEmoji(name: String) -> Emojis? {
        var result: Emojis?
        context.performAndWait {
            let fetchRequest: NSFetchRequest<Emojis> = Emojis.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            fetchRequest.fetchLimit = 1
            do {
                result = try context.fetch(fetchRequest).first
            } catch {
                print("Failed to fetch emoji: \(error)")
            }
        }
        return result
    }
    
    func getRandomEmoji() -> Emojis? {
        let emojis = getAll()
        return emojis.isEmpty ? nil : emojis.randomElement()
    }
    
    func update(emoji: Emojis) -> Bool {
        var success = false
        context.performAndWait {
            do {
                try context.save()
                success = true
            } catch {
                print("Failed to update emoji: \(error)")
                success = false
            }
        }
        return success
    }
    
    func delete(record: Emojis) -> Bool {
        var success = false
        context.performAndWait {
            context.delete(record)
            do {
                try context.save()
                success = true
            } catch {
                print("Failed to delete emoji: \(error)")
                success = false
            }
        }
        return success
    }
    
    func deleteAllEmojis() {
        context.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Emojis")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(batchDeleteRequest)
                try context.save()
                print("Deleted all emojis from Core Data")
            } catch {
                print("Failed to delete all emojis: \(error)")
            }
        }
    }
}
