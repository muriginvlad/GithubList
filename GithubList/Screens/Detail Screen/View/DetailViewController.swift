//
//  DetailViewController.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation
import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!
    
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()
    
    var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.image = UIImage(systemName:"face.smiling")
        imageView.isHidden = true
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "nameLabel"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    var emailLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "emailLabel"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    var organizationLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "organizationLabel"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    var followingLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "organizationLabel"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    var followersLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "organizationLabel"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    var creationLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "organizationLabel"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.isHidden = true
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setAndAddViews()
        setConstraints()
    }
    
    private func setAndAddViews(){
        view.addSubview(avatarView)
        view.addSubview(stackView)
        view.addSubview(spinner)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(organizationLabel)
        stackView.addArrangedSubview(followingLabel)
        stackView.addArrangedSubview(followersLabel)
        stackView.addArrangedSubview(creationLabel)
    }
    
    private func setConstraints(){
        avatarView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 100, height: 100))
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.bottom).offset(10)
            $0.left.right.centerX.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
        
        spinner.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    private func showAlert(text: String) {
        let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Попробовать снова", style: .default, handler: { action in
            self.spinner.isHidden = false
            self.spinner.stopAnimating()
            self.presenter.reload()
        }))
        alert.addAction(UIAlertAction(title: "Отменить", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension DetailViewController:  DetailViewProtocol {
   
    func failure(error: Error) {
        spinner.stopAnimating()
        spinner.isHidden = true
        
        self.showAlert(text: error.localizedDescription)
    }
    
    func setUserInfo(user: UserData?) {
        spinner.stopAnimating()
        spinner.isHidden = true
        avatarView.isHidden = false
        stackView.isHidden = false
        
        if let user = user {
            avatarView.kf.setImage(with: user.avatar,
                                   placeholder: UIImage(named: "face.smiling"),
                                   options: [.cacheOriginalImage])
            
            nameLabel.text = user.name
            emailLabel.text = user.email
            organizationLabel.text = user.organization ?? ""
            followingLabel.text = "Following: \(user.following)"
            followersLabel.text = "Followers: \(user.followers)"
            creationLabel.text = "Дата регистрации: \(user.created)"
        }
    }
}
