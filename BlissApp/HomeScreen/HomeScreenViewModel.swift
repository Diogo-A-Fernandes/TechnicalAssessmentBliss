//
//  HomeScreenViewModel.swift
//  BlissApp
//
//  Created by Diogo on 8/8/25.
//

import UIKit

class HomeScreenViewModel {
    
    private let _emojiRepository : EmojisRepository = EmojisDataRepository()
    private let _avatarsRepository : AvatarsRepository = AvatarsDataRepository()
    var lastSearchText: String?
    
    func getEmojisRecord(completionHandler: @escaping (Emojis?) -> Void) {
        let emojis = _emojiRepository.getAll()
        
        if !emojis.isEmpty {
            let randomEmoji = _emojiRepository.getRandomEmoji()
                completionHandler(randomEmoji)
            
        } else {
            _emojiRepository.fetchDataFromAPIAndCreate { _ in
                let randomEmoji = self._emojiRepository.getRandomEmoji()
                    completionHandler(randomEmoji)
            }
        }
    }
    
    func getAvatarRecord(username: String, completionHandler: @escaping (Avatars?) -> Void) {
        
        if let existingAvatar = _avatarsRepository.getAvatar(username: username
        ) {
            completionHandler(existingAvatar)
            return
        } else {
            _avatarsRepository.fetchDataAPIAndCreate(username: username) { result in
                completionHandler(result)
            }
        }
        
    }
    
}
