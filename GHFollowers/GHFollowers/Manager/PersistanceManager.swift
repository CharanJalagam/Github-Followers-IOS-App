//
//  PersistanceManager.swift
//  GHFollowers
//
//  Created by Blaze macbook pro on 06/09/24.
//

import Foundation
enum actionType{
    case add,remove
}

enum PersistanceManager{
    
    static let defaults = UserDefaults.standard
    
    enum Keys{
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: actionType, completed: @escaping(GFError?)-> Void){
        retrieveData { result in
            switch result{
            case .success(let favorites):
                var retrivedFollowers = favorites
                
                switch actionType{
                case .add :
                    guard !retrivedFollowers.contains(favorite) else{
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrivedFollowers.append(favorite)
                case.remove :
                    retrivedFollowers.removeAll{ $0.login == favorite.login}
                }
                completed(save(favorites: retrivedFollowers))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveData(completed: @escaping(Result<[Follower],GFError>)-> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else{
            return completed(.success([]))
        }
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            return completed(.success(favorites))
        }catch{
            return completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower])-> GFError?{
        do{
            let encodeFav = try JSONEncoder().encode(favorites)
            defaults.set(encodeFav, forKey: Keys.favorites)
            return nil
        }catch{
            return GFError.unableToFavorite
        }
    }
}
