//
//  GitUserCellModel.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation
import UIKit

struct GitUserCellModel  {
    
    let login: String
    let id: Int
    let avatar: URL?
    
    init(_ data: MainUserNetworkModel){
        self.login = data.login
        self.id = data.id
        self.avatar = URL(string: data.avatarURL)
    }
    
}
