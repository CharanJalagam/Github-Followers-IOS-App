//
//  FavoritesCell.swift
//  GHFollowers
//
//  Created by Blaze macbook pro on 06/09/24.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    static let reuseID = "FavoritesCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let username = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower) {
        username.text = favorite.login
        avatarImageView.downloadImage(imageURL: favorite.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(username)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        // Make sure to disable autoresizing masks
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            username.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            username.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            username.heightAnchor.constraint(equalToConstant: 60),
            username.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])
    }
}
