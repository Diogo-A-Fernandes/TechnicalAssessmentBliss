//
//  HomeScreenViewModel.swift
//  BlissApp
//
//  Created by Diogo on 8/8/25.
//

import UIKit

class HomeScreenViewModel{
    
    
    func getRandomEmojiData(){
        APICaller.getEmojies { result in
            switch result{
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getOneEmoji(){
        
    }
    
    func createEmoji(name: String, image: String){
        
    }
    
}
