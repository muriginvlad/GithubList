//
//  MainViewPresenter.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation
import PromiseKit

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    var users: [GitUserCellModel]? {get set}
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    func tapOnUser(user: String)
    func getFirstUsersList()
    func loadMoreUsersList()
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    weak private var searchViewDelegate: MainViewPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    private var router: RouterProtocol?
    private var lastLoadId = 0
    weak var view: MainViewProtocol?
    var users: [GitUserCellModel]?
    
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func getFirstUsersList() {
        self.lastLoadId = 0
        
        self.networkService.getAllUser(since: lastLoadId)
            .done(on: DispatchQueue.main) { [weak self] users in
                self?.users = users.map { GitUserCellModel.init($0) }
                self?.view?.success()
            }
            .catch { error in
                self.view?.failure(error: error)
            }
    }
    
    func loadMoreUsersList(){
        if let lastElement = self.users?.last {
            lastLoadId = lastElement.id
        }
        
        self.networkService.getAllUser(since: lastLoadId)
            .done(on: DispatchQueue.main) { [weak self] users in
                _ = users.map {
                    self?.users?.append(GitUserCellModel.init($0))
                }
                self?.view?.success()
            }
            .catch { error in
                self.view?.failure(error: error)
            }
    }
    
    func tapOnUser(user: String) {
         self.router?.showUserDetails(user: user)
    }
}

