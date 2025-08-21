//
//  APICaller.swift
//  BlissApp
//
//  Created by Diogo on 8/8/25.
//

import UIKit

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller {
    
    private static let itemsSize = 10
    private static var pageNumber = 1
    
    
    // MARK: - Emojis
    static func getEmojies(completionHandler: @escaping (_ result: Result<EmojisModel, NetworkError>) -> Void) {
        
        let urlString = NetworkingConstant.shared.emojiApi
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, _, error in
            guard error == nil, let data = dataResponse else {
                completionHandler(.failure(.canNotParseData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(EmojisModel.self, from: data)
                completionHandler(.success(result))
            } catch {
                print("Decoding error (Emojis):", error)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    // MARK: - Avatar
    static func getAvatar(username: String, completionHandler: @escaping (_ result: Result<AvatarsModel, NetworkError>) -> Void) {
        
        let urlString = NetworkingConstant.shared.usersApi + username
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, _, error in
            guard error == nil, let data = dataResponse else {
                completionHandler(.failure(.canNotParseData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AvatarsModel.self, from: data)
                completionHandler(.success(result))
            } catch {
                print("Decoding error (Avatar):", error)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    // MARK: - Apple Repos
    static func getAppleRepos(completionHandler: @escaping (_ result: Result<[RepositoriesModel], NetworkError>) -> Void) {
        
        let urlString = NetworkingConstant.shared.repositoriesApi + "page=\(pageNumber)&per_page=\(itemsSize)"
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, _, error in
            guard error == nil, let data = dataResponse else {
                completionHandler(.failure(.canNotParseData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([RepositoriesModel].self, from: data)
                pageNumber += 1
                completionHandler(.success(result))
            } catch {
                print("Decoding error (Repositories):", error)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}
