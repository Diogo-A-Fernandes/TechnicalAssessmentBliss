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
    var isLoading = Observable(false)
    var warningMessage = Observable<String?>(nil)

    
    func getEmojisRecord(completionHandler: @escaping (Emojis?) -> Void) {
        isLoading.value = true
        
        let emojis = _emojiRepository.getAll()
        
        if !emojis.isEmpty {
            let randomEmoji = _emojiRepository.getRandomEmoji()
            isLoading.value = false
                completionHandler(randomEmoji)
            
        } else {
            _emojiRepository.fetchDataFromAPIAndCreate { _ in
                let randomEmoji = self._emojiRepository.getRandomEmoji()
                self.isLoading.value = false
                    completionHandler(randomEmoji)
            }
        }
    }
    
    func getAvatarRecord(username: String, completionHandler: @escaping (Avatars?) -> Void) {
        
        warningMessage.value = nil
        
        if let existingAvatar = _avatarsRepository.getAvatar(username: username
        ) {
            completionHandler(existingAvatar)
            return
        } else {
            _avatarsRepository.fetchDataAPIAndCreate(username: username) { result in

                if let avatar = result {
                                   completionHandler(avatar)
                               } else {
                                   self.warningMessage.value = "No user was found."
                                   completionHandler(nil)
                               }
                            }
        }
        
    }
    
}
