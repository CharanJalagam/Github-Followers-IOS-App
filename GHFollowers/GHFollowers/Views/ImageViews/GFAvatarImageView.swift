//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Blaze macbook pro on 11/08/24.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeholder = UIImage(named: "avatar-placeholder")
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        image = placeholder
    }
    
    func downloadImage(imageURL: String){
        guard let url = URL(string: imageURL) else{return}
        
        let cacheKey = NSString(string: imageURL)
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {return}
            if error != nil {return}
            guard let response = response else {return}
            guard let data = data else {return}
            
            guard let image = UIImage(data: data) else {return}
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
