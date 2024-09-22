//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Blaze macbook pro on 25/08/24.
//

import UIKit

class GFFollowerItemVC: GFItemsInfoVC{
    
    override func viewDidLoad() {
         super.viewDidLoad()
        configureItems()
    }
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    
    func configureItems(){
        infoItemViewOne.set(itemInfoType: .followers, withCount: user.followers)
        infoItemViewTwo.set(itemInfoType: .following , withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, withTitle: "Get Followers")
    }
}
