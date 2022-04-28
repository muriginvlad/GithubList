//
//  GitUserNetworkModel.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation

struct UserDetailNetworkModel: Codable {
    
    let login: String?
    let id: Int?
    let avatarURL: String?
    let organizationsURL: String?
    let name: String?
    let company: String?
    let email: String?
    let followers: Int?
    let following: Int?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case organizationsURL = "organizations_url"
        case name, company, email
        case followers, following
        case createdAt = "created_at"
    }
}
