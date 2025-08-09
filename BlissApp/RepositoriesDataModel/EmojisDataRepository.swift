//
//  EmojisDataRepository.swift
//  BlissApp
//
//  Created by Diogo on 8/9/25.
//

import CoreData

protocol EmojisRepository {
    func create(emoji: Emojis)
    func getAll() -> [Emojis]?
    func getEmoji(name: String) -> Emojis?
    func getRandomEmoji() -> Emojis?
    func update(emoji: Emojis) -> Bool
    func delete(record: Emojis) -> Bool
}

struct EmojisDataRepository: EmojisRepository {
    
    func create(emoji: Emojis) {
        let newEmoji = Emojis(context: PersistentStorage.shared.context)
        newEmoji.name = emoji.name
        newEmoji.image = emoji.image
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Emojis]? {
        
        return PersistentStorage.shared.fetchManagedObject(managedObject: Emojis.self)
    }
    
    func getEmoji(name: String) -> Emojis? {
        
        let fetchRequest: NSFetchRequest<Emojis> = Emojis.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.fetchLimit = 1
        
        do {
            return try PersistentStorage.shared.context.fetch(fetchRequest).first
        } catch {
            print("Error fetching emoji by name: \(error)")
            return nil
        }
    }
    
    
    func getRandomEmoji() -> Emojis? {
        
        guard let emojisList = getAll(), !emojisList.isEmpty else {
            return nil
        }
        
        return emojisList.randomElement()
    }
    
    func update(emoji: Emojis) -> Bool{
        return false
    }
    
    func delete(record: Emojis) -> Bool {
        guard let name = record.name else { return false }
        guard let emoji = getEmoji(name: name) else { return false }
        
        PersistentStorage.shared.context.delete(emoji)
        PersistentStorage.shared.saveContext()
        
        return true
    }
}
