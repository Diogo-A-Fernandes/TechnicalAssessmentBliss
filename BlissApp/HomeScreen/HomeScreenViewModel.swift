//
//  HomeScreenViewModel.swift
//  BlissApp
//
//  Created by Diogo on 8/8/25.
//

import UIKit

class HomeScreenViewModel {
    
    private let _emojiRepository : EmojisRepository = EmojisDataRepository()
    
    func getEmojisRecord(completionHandler: @escaping (Emojis?) -> Void) {
        if let savedEmojis = _emojiRepository.getAll(), !savedEmojis.isEmpty {
            let randomEmoji = _emojiRepository.getRandomEmoji()
            completionHandler(randomEmoji)
        } else {
            getEmojiData { _ in
                let randomEmoji = self._emojiRepository.getRandomEmoji()
                completionHandler(randomEmoji)
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
                    print("Could not fetch emojis after saving")
                    completionHandler([])
                }
            case .failure(let error):
                print("API failed with error: \(error.localizedDescription)")
                completionHandler([])
            }
        }
    }
    
}
