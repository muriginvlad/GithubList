//
//  DetailViewPresenter.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setUserInfo(user: UserData?)
    func failure(error: Error)
    
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, user: String)
    func setUserInfo()
    func tapBack()
    func reload()
}

class DetailViewPresenter: DetailViewPresenterProtocol {
    
    private let networkService: NetworkServiceProtocol
    private var userName: String
    weak private var searchViewDelegate: DetailViewPresenterProtocol?
    weak var view: DetailViewProtocol?
    
    var router: RouterProtocol?
    var userData: UserData?
    
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, user: String) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.userName = user
        
        setData(user)
    }
    
    private func setData(_ user: String){
        self.networkService.getSingleUser(userName: user)
            .done(on: DispatchQueue.main) { [weak self] user in
                self?.userData = UserData.init(user)
                self?.setUserInfo()
            }
            .catch { error in
                self.view?.failure(error: error)
            }
    }
    
    func reload(){
        setData(userName)
    }
    
    func setUserInfo() {
        self.view?.setUserInfo(user: self.userData)
    }
    
    func tapBack() {
        self.router?.popToRoot()
    }

}

