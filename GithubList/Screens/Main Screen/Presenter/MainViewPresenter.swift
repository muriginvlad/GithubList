//
//  MainViewPresenter.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation

protocol MainViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
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
        
        networkService.getAllUser(since: lastLoadId) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    if let data = users {
                        self.users = data.map {
                            GitUserCellModel.init($0)
                        }
                    }
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func loadMoreUsersList(){
        if let lastElement = self.users?.last {
            lastLoadId = lastElement.id
        }
        
        networkService.getAllUser(since: lastLoadId) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                                        
                    users?.forEach {
                        self.users?.append(GitUserCellModel.init($0))
                    }
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
        DispatchQueue(label: <#T##String#>)
    }
    
    func tapOnUser(user: String) {
         self.router?.showUserDetails(user: user)
    }
}

