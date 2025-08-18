//
//  RepositoriesViewModel.swift
//  BlissApp
//
//  Created by Diogo on 8/18/25.
//

import UIKit

class RepositoriesViewModel {
    
    private let _appleRepository : AppleRepository = AppleDataRepository()
    var tempReposArray : [AppleRepos] = []

    func getRepositoriesRecord(completionHandler: @escaping ([AppleRepos]) -> Void) {
       
        let savedRepos  = _appleRepository.getAll()
        
        if !savedRepos .isEmpty {
            tempReposArray = savedRepos 
            completionHandler(tempReposArray)
        } else {
            getReposData { result in
                self.tempReposArray = result
                completionHandler(self.tempReposArray)
            }
        }
    }
    
    func getReposData(completionHandler: @escaping ([AppleRepos]) -> Void) {
        
        APICaller.getAppleRepos { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
               
                for repo in data {
                    self._appleRepository.create(name: repo.name)
                }
                
                let repos = self._appleRepository.getAll()
                completionHandler(repos)
                
            case .failure(let error):
                print("API failed with error: \(error.localizedDescription)")
                completionHandler([])
            }
        }
    }
    
    func numberOfItems() -> Int {
        return tempReposArray.count
    }
    
}
