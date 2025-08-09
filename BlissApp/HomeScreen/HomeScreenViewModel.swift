//
//  HomeScreenViewModel.swift
//  BlissApp
//
//  Created by Diogo on 8/8/25.
//

import UIKit

class HomeScreenViewModel {
    
    private let context = PersistentStorage.shared.context
    
    func getRandomEmojiData(){
        APICaller.getEmojies { result in
            switch result {
            case .success(let data):
                print(data)
                //self.createEmoji(data: data)
                //self.getOneEmojis()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getOneEmojis() {
        
        do {
            guard let result = try context.fetch(Emojis.fetchRequest()) as? [Emojis] else {
                return
            }
            
            result.forEach { print($0) }

        } catch let error {
            print(error)
        }
    }
    
    func createEmoji(data: [String: String]) {
        
        for(key,value) in data {
            let emoji = Emojis(context: context)
            emoji.name = key
            emoji.image = value
        }
        do {
            try context.save()
        } catch let error{
            print("Failed to save emojis: \(error)")
        }
    }
    
}
