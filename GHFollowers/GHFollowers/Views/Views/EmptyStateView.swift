//
//  EmptyStateView.swift
//  GHFollowers
//
//  Created by Blaze macbook pro on 19/08/24.
//

import UIKit

class EmptyStateView: UIView {
    
    var messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    var logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String){
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    func configure(){
        addSubview(logoImageView)
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.4),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.4),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 190),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 80)
        ])
    }
}
