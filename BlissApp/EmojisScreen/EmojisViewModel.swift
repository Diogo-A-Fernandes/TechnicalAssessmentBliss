//
//  EmojisViewModel.swift
//  BlissApp
//
//  Created by Diogo on 8/9/25.
//

import UIKit

class EmojisViewModel {
    
    private let _emojiRepository : EmojisRepository = EmojisDataRepository()
    var tempEmojisArray : [Emojis] = []
    var isLoading = Observable(false)

    
    func getEmojisRecord(completionHandler: @escaping ([Emojis]) -> Void) {
        
        isLoading.value = true
        
        let savedEmojis = _emojiRepository.getAll()
        
        if !savedEmojis.isEmpty {
            tempEmojisArray = savedEmojis
            isLoading.value = false
            completionHandler(tempEmojisArray)
        } else {
            _emojiRepository.fetchDataFromAPIAndCreate { result in
                 self.tempEmojisArray = result
                 self.isLoading.value = false
                completionHandler(self.tempEmojisArray)
            }
        }
    }

    func numberOfItems() -> Int {
        return tempEmojisArray.count
    }
    
    func refreshTempArrayData() -> [Emojis] {
        let emojis = _emojiRepository.getAll()
        tempEmojisArray = emojis
        return emojis
    }
}
