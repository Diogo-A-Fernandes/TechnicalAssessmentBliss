//
//  EmojisDataRepository.swift
//  BlissApp
//
//  Created by Diogo on 8/9/25.
//

import CoreData

protocol EmojisRepository {
    func fetchDataFromAPIAndCreate(completion: @escaping ([Emojis]) -> Void)
    func getAll() -> [Emojis]
    func getRandomEmoji() -> Emojis?
    func deleteAll()
}

struct EmojisDataRepository: EmojisRepository {
    
    private var context: NSManagedObjectContext {
        return PersistentStorage.shared.context
    }
    
    func fetchDataFromAPIAndCreate(completion: @escaping ([Emojis]) -> Void) {
        APICaller.getEmojies { result in
            switch result {
            case .success(let data):
                context.perform {
                    for (name, image) in data {
                        guard !name.isEmpty, !image.isEmpty else { continue }
                        if self.getEmoji(name: name) == nil {
                            let newEmoji = Emojis(context: context)
                            newEmoji.name = name
                            newEmoji.image = image
                            print(newEmoji)
                        }
                    }
                    
                    do {
                        try context.save()
                        let emojis = self.getAll()
                        completion(emojis)
                    } catch {
                        print("Failed to save emojis: \(error.localizedDescription)")
                        completion([])
                    }
                }
            case .failure(let error):
                print("API failed with error: \(error.localizedDescription)")
                completion([])
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
    
    func deleteAll() {
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
