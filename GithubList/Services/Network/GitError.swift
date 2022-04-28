//
//  GitError.swift
//  GithubList
//
//  Created by Vladislav on 28.04.2022.
//

import Foundation

enum GitError: LocalizedError {
    case somethingIsWrong(info: String)
    
    public var errorDescription: String? {
        switch self {
        case .somethingIsWrong(info: let info):
            return "Что-то не так с GitHub: \n\(info)"
        }
    }
}
