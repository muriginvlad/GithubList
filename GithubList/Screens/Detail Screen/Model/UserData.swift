//
//  UserData.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation


struct UserData: Codable {
    
    let name: String
    let email: String
    let organization: String?
    let organizationsURL : String?
    let following: Int
    let followers: Int
    let created: Date
    let avatar: URL?
    
    init(_ data: UserDetailNetworkModel){
        self.name = data.name ?? ""
        self.email = data.email ?? ""
        self.organizationsURL = data.organizationsURL
        self.organization = data.company
        self.following = data.following ?? 0
        self.followers = data.followers ?? 0
        self.created = data.createdAt?.toDate(.isoDate) ?? Date()
        self.avatar = URL(string: data.avatarURL ?? "")
    }
}
