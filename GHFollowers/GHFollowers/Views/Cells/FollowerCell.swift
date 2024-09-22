//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Blaze macbook pro on 11/08/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let username = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower){
        username.text = follower.login
        avatarImageView.downloadImage(imageURL: follower.avatarUrl)
    }
    
    private func configure(){
        addSubview(avatarImageView)
        addSubview(username)
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            username.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            username.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            username.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            username.heightAnchor.constraint(equalToConstant: 20)
        
        ])
    }
}
