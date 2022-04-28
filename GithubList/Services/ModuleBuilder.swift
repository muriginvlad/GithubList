//
//  ModuleBuilder .swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createUserModule(user: String, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainViewPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createUserModule(user: String, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailViewPresenter(view: view, networkService: networkService, router: router, user: user)
        view.presenter = presenter
        return view
    }
}
