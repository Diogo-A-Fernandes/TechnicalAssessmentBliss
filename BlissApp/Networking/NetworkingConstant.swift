//
//  NetworkingConstant.swift
//  BlissApp
//
//  Created by Diogo on 8/8/25.
//

import UIKit

class NetworkingConstant{
    
    public static var shared: NetworkingConstant = NetworkingConstant()
    
    private init(){
        
    }
    
    public var emojiApi: String{
        get{
            return "https://api.github.com/emojis"
        }
    }
    
    public var usersApi: String{
        get{
            return "https://api.github.com/users/"
        }
    }
    
    public var repositoriesApi: String{
        get{
            return "https://api.github.com/users/username/repos"
        }
    }
}
