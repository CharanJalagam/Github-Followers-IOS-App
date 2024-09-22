//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Blaze macbook pro on 25/08/24.
//

import UIKit

class GFRepoItemVC: GFItemsInfoVC{
    
    override func viewDidLoad() {
         super.viewDidLoad()
        configureItems()
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
    
    func configureItems(){
        infoItemViewOne.set(itemInfoType: .repo, withCount: user.publicRepos)
        infoItemViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, withTitle: "GitHub Profile")
    }
}
