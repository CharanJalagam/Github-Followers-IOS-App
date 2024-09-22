//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Blaze macbook pro on 28/07/24.
//

import UIKit

class FavoritesListVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var tableView = UITableView()
    var favorites:[Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewConroller()
        configureTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        getFavorites()
    }
    func configureViewConroller(){
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
    }
    
    func getFavorites(){
        PersistanceManager.retrieveData { result in
            switch result{
            case .success(let followers):
                if followers.isEmpty{
                    self.showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen", in: self.view)
                }
                else{
                    self.favorites = followers
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseID) as! FavoritesCell
        let fav = favorites[indexPath.row]
        cell.set(favorite: fav)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fav = favorites[indexPath.row]
        
        let destVC = FollowerListVC()
        destVC.username = fav.login
        destVC.title = fav.login
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else{return}
        
        let fav = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.updateWith(favorite: fav, actionType: .remove) { error in
            guard let error = error else{return}
            self.presentGFAlertOnMainThread(title: "Unable to remove ", message: error.rawValue, buttonTitle: "Ok")
        }
        
        
    }
}
