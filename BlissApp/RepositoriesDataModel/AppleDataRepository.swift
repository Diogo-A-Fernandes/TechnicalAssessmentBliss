//
//  AppleRepos.swift
//  BlissApp
//
//  Created by user284977 on 8/18/25.
//

import CoreData

protocol AppleRepository {
    func fetchDataAPIAndCreate(completionHandler: @escaping ([AppleRepos]) -> Void)
    func getAll() -> [AppleRepos]
    func deleteAll()
}

struct AppleDataRepository: AppleRepository {
   
    private var context: NSManagedObjectContext {
        return PersistentStorage.shared.context
    }
    
    func fetchDataAPIAndCreate(completionHandler: @escaping ([AppleRepos]) -> Void) {
        APICaller.getAppleRepos { result in
            switch result {
            case .success(let data):
                context.perform {
                    for repo in data {
                        guard !repo.name.isEmpty else { continue }
                        if self.getRepo(name: repo.name) == nil {
                            let newRepo = AppleRepos(context: context)
                            newRepo.name = repo.name
                        }
                    }
                    
                    do {
                        try context.save()
                        completionHandler(self.getAll())
                    } catch {
                        print("Failed to save repos: \(error.localizedDescription)")
                        completionHandler([])
                    }
                }
                
            case .failure(let error):
                print("API failed with error: \(error.localizedDescription)")
                completionHandler([])
            }
        }
    }
    
    private func getRepo(name: String) -> AppleRepos? {
        let request: NSFetchRequest<AppleRepos> = AppleRepos.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name.lowercased())
        return try? context.fetch(request).first
    }
    
    func getAll() -> [AppleRepos] {
        return PersistentStorage.shared.fetchManagedObject(managedObject: AppleRepos.self) ?? []
    }
    
    func deleteAll() {
        context.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppleRepos")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try? context.execute(batchDeleteRequest)
            try? context.save()
        }
    }
}
