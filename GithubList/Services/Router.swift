//
//  Router.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? {get set}
    var moduleBuilder: ModuleBuilderProtocol? {get set}
}
protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showUserDetails(user: String)
    func popToRoot()
}
class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = self.moduleBuilder?.createMainModule(router: self) else {return}
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showUserDetails(user: String) {
        if let navigationController = navigationController {
            guard let artistViewController = self.moduleBuilder?.createUserModule(user: user, router: self) else {return}
            navigationController.pushViewController(artistViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}

