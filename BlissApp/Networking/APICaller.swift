//
//  APICaller.swift
//  BlissApp
//
//  Created by Diogo on 8/8/25.
//

import UIKit

enum NetworkError: Error{
    case urlError
    case canNotParseData
}

public class APICaller{
    
    static func getEmojies(completionHandler: @escaping(_ result: Result<EmojisModel,NetworkError>) -> Void){
        
        let urlString = NetworkingConstant.shared.emojiApi
        
        guard let url = URL(string: urlString) else{
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url){dataResponse, urlResponse, error in
            if error == nil,
               let data = dataResponse,
               let result = try? JSONDecoder().decode(EmojisModel.self,from: data){
                completionHandler(.success(result))
            }
            else{
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}

