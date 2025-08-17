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
                let emojis = self._emojiRepository.getAll()
                completionHandler(emojis)
            case .failure(let error):
                print("API failed with error: \(error.localizedDescription)")
                completionHandler([])
            }
        }
    }
    
    func getAvatarRecord(username: String, completionHandler: @escaping (Avatars?) -> Void) {
        
        if let existingAvatar = _avatarsRepository.getAvatar(username: username
        ) {
            completionHandler(existingAvatar)
            print("I was here")
            return
        }
        
        APICaller.getAvatar(username: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):

                guard let name = data.login, let avatarURL = data.avatarURL else {
                    completionHandler(nil)
                    return
                }
                
                let avatar = self._avatarsRepository.create(username: name, image: avatarURL)
                
                print(self._avatarsRepository.getAll())
                completionHandler(avatar)
                
            case .failure(let error):
                print("API failed with error: \(error.localizedDescription)")
                completionHandler(nil)
            }
        }
    }
    
}
