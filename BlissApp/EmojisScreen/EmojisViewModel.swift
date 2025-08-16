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
    
    func getEmojisRecord(completionHandler: @escaping ([Emojis]?) -> Void) {
        if let savedEmojis = _emojiRepository.getAll(), !savedEmojis.isEmpty {
            tempEmojisArray = savedEmojis
            completionHandler(tempEmojisArray)
        } else {
            getEmojiData { result in
                self.tempEmojisArray = result
                completionHandler(self.tempEmojisArray)
            }
        }
    }
    
    
    func getEmojiData(completionHandler: @escaping ([Emojis]) -> Void) {
        APICaller.getEmojies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                data.forEach { (name, image) in
                    guard !name.isEmpty, !image.isEmpty else {
                        print("Invalid emoji data skipped: \(name): \(image)")
                        return
                    }
                    self._emojiRepository.create(name: name, image: image)
                }

                if let emojis = self._emojiRepository.getAll() {
                    completionHandler(emojis)
                } else {
                    completionHandler([])
                }
            case .failure(let error):
                print("API failed with error: \(error.localizedDescription)")
                completionHandler([])
            }
        }
    }
    
    
    func numberOfItems() -> Int {
        return tempEmojisArray.count
    }
    
    func fetchEmojisFromCoreData() -> [Emojis] {
        let emojis = _emojiRepository.getAll() ?? []
        tempEmojisArray = emojis
        return emojis
    }

}
