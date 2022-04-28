//
//  GitAlertNetworkModel.swift
//  GithubList
//
//  Created by Vladislav on 28.04.2022.
//

import Foundation

struct GitAlertNetworkModel: Codable {
    let message: String?
    let documentationURL: String?

    enum CodingKeys: String, CodingKey {
        case message
        case documentationURL = "documentation_url"
    }
}
