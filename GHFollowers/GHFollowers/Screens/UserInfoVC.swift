//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Blaze macbook pro on 19/08/24.
//

import UIKit
import SafariServices

protocol UserInfoDelegate: AnyObject{
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {

    var username: String!
    
    let headerView = UIView()
    let ItemViewOne = UIView()
    let ItemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var delegate: FollowerListDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        layoutUI()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let user):
                DispatchQueue.main.async {
                    let repoItem = GFRepoItemVC(user: user)
                    repoItem.delegate = self
                    let followerItem = GFFollowerItemVC(user: user)
                    followerItem.delegate = self
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: repoItem, to: self.ItemViewOne)
                    self.add(childVC: followerItem , to: self.ItemViewTwo)
                    self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayDate())"
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong!!", message: error.rawValue, buttonTitle: "OK")
            }
        
        }
        
    }
    
    func layoutUI(){
        view.addSubview(headerView)
        view.addSubview(ItemViewOne)
        view.addSubview(ItemViewTwo)
        view.addSubview(dateLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        ItemViewOne.translatesAutoresizingMaskIntoConstraints = false
        ItemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            ItemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            ItemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            ItemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            ItemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            ItemViewTwo.topAnchor.constraint(equalTo: ItemViewOne.bottomAnchor, constant: 20),
            ItemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            ItemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            ItemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: ItemViewTwo.bottomAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }

}
extension UserInfoVC: UserInfoDelegate{
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else{
            presentGFAlertOnMainThread(title: "Invalid Url", message: "Something went wrong!!!", buttonTitle: "Ok")
            return
        }
        presentSafariVC(url: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else{
            presentGFAlertOnMainThread(title: "No Followers", message: "This user have no followers", buttonTitle: "Ok")
            return
        }
        
        delegate.getFollowers(username: user.login)
        dismissVC()
    }
    
    
}
