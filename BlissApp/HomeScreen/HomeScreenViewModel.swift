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
        APICaller.getEmojies { result in
            switch result {
            case .success(let data):
                print("API success, saving emojis to Core Data...")
                data.forEach { (name, image) in
                    let emoji = Emojis(context: PersistentStorage.shared.context)
                    emoji.name = name
                    emoji.image = image
                    self._emojiRepository.create(emoji: emoji)
                }
                if let emojis = self._emojiRepository.getAll() {
                    print("Emojis saved and fetched from Core Data: \(emojis.count)")
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
