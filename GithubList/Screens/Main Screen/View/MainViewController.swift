//
//  MainViewController.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 60
        view.register(GitUserCell.self, forCellReuseIdentifier: "Cell")
        view.delegate = self
        view.dataSource = self
        return view
    }()

    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Пользователи GitHub"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setAndAddViews()
        setConstraints()
        presenter.getFirstUsersList()
    }

    private func setAndAddViews(){
        view.addSubview(tableView)
        
        tableView.addSubview(refreshControl)
        tableView.backgroundColor = .white
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    private func setConstraints(){
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.presenter.getFirstUsersList()
    }
    
}

extension MainViewController: MainViewProtocol {
    func success() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        refreshControl.endRefreshing()
        print(error)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GitUserCell
        cell.set(self.presenter.users?[indexPath.row])
        if indexPath.row == (self.presenter.users?.count ?? 0) - 10 {
                self.presenter.loadMoreUsersList()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.presenter.users?[indexPath.row]
        if let userName = user?.login {
            self.presenter.tapOnUser(user: userName)
        }
    }
}
