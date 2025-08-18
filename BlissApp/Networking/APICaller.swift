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
    
    static func getAvatar(username: String, completionHandler: @escaping(_ result: Result<AvatarsModel,NetworkError>) -> Void) {
        
        let urlString = NetworkingConstant.shared.usersApi + username
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        print(url)
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            
            guard error == nil, let data = dataResponse else {
                completionHandler(.failure(.canNotParseData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let result = try decoder.decode(AvatarsModel.self, from: data)
                completionHandler(.success(result))
            } catch {
                print("Decoding error:", error)
                completionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
    }
    
    static func getAppleRepos(completionHandler: @escaping (_ result: Result<[RepositoriesModel], NetworkError>) -> Void) {
        
        let urlString = NetworkingConstant.shared.repositoriesApi + "page=1&per_page=10"
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        print(url)
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            
            guard error == nil, let data = dataResponse else {
                completionHandler(.failure(.canNotParseData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let result = try decoder.decode([RepositoriesModel].self, from: data)
                completionHandler(.success(result))
            } catch {
                print("Decoding error:", error)
                completionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
    }
}
