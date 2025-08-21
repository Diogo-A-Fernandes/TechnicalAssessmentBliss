//
//  RepositoriesViewModel.swift
//  BlissApp
//
//  Created by Diogo on 8/18/25.
//

class RepositoriesViewModel {
    
    private let _appleRepository : AppleRepository = AppleDataRepository()
    var tempReposArray : [AppleRepos] = []
    
    private var hasMorePages = true
    var isLoading = Observable(false)

    func getRepositoriesRecord(completionHandler: @escaping ([AppleRepos]) -> Void) {
        let savedRepos = _appleRepository.getAll()
        
        if !savedRepos.isEmpty {
            tempReposArray = savedRepos
            completionHandler(tempReposArray)
        } else {
            loadMore(completionHandler: completionHandler)
        }
    }
    
    func loadMore(completionHandler: @escaping ([AppleRepos]) -> Void) {
        guard !isLoading.value!, hasMorePages else { return }
        
        isLoading.value = true
        _appleRepository.fetchDataAPIAndCreate { [weak self] result in
            guard let self = self else { return }
            
            if result.isEmpty {
                self.hasMorePages = false
            } else {
                self.tempReposArray = result
            }
            
            self.isLoading.value = false
            completionHandler(self.tempReposArray)
        }
    }
    
    func numberOfItems() -> Int {
        return tempReposArray.count
    }
}
