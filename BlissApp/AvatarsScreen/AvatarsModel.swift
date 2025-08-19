//
//  AvatarsModel.swift
//  BlissApp
//
//  Created by Diogo on 8/16/25.
//

// MARK: - AvatarsModel
struct AvatarsModel: Codable {
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
