//
//  GFButton.swift
//  GHFollowers
//
//  Created by Blaze macbook pro on 01/08/24.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(bgColor: UIColor, title: String){
        super.init(frame: .zero)
        self.backgroundColor = bgColor
        setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    func set(backgroundColor : UIColor, withTitle title: String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
