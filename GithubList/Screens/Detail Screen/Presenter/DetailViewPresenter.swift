//
//  DetailViewPresenter.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation

protocol DetailViewProtocol: class {
    func setUserInfo(user: UserData?)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, user: String)
    func setUserInfo()
    func tapBack()
}

class DetailViewPresenter: DetailViewPresenterProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    weak private var searchViewDelegate: DetailViewPresenterProtocol?
    weak var view: DetailViewProtocol?
    
    var router: RouterProtocol?
    var user: UserData?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, user: String) {
        self.view = view
        self.networkService = networkService
        self.router = router
        setData(user)
        
    }
    
    private func setData(_ user: String){
        networkService.getSingleUser(userName: user) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    if let data = user {
                        self.user = UserData.init(data)
                        self.setUserInfo()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func setUserInfo() {
        self.view?.setUserInfo(user: self.user)
    }
    
    func tapBack() {
        self.router?.popToRoot()
    }

}

