//
//  GitUserCell.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import UIKit
import SnapKit
import Kingfisher

class GitUserCell: UITableViewCell {
    
    var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.image = UIImage(systemName:"face.smiling")
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "titleLabel"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "subtitleLabel"
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        return subtitleLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        setConstraints()
        return contentView.frame.size
    }
    
    func set(_ data: GitUserCellModel?) {
        titleLabel.text = "Имя пользователя: \(data?.login ?? "")"
        subtitleLabel.text = "id пользователя: \(data?.id ?? 0 )"
        
        if let link = data?.avatar {
            avatarView.kf.setImage(with: link,
                                   placeholder: UIImage(named: "face.smiling"),
                                   options: [.cacheOriginalImage])
        }
        
        layoutSubviews()
    }
    
    private func setUpViews(){
        contentView.addSubview(avatarView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }
    
    private func setConstraints(){
        avatarView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 40, height: 40)).priority(999)
            $0.top.greaterThanOrEqualTo(10)
            $0.left.equalTo(self.contentView.snp.left).offset(20)
            $0.centerY.equalTo(self.contentView.snp.centerY)
            $0.bottom.lessThanOrEqualTo(10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(avatarView)
            $0.left.equalTo(avatarView.snp.right).offset(10.0)
            $0.right.equalTo(self.contentView.snp.right).inset(20)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.equalTo(titleLabel)
            $0.right.equalTo(titleLabel).inset(20)
            $0.bottom.lessThanOrEqualTo(5)
        }
    }
}
