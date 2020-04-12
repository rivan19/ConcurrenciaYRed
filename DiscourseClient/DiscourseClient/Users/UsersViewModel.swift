//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UsersCoordinatorDelegate: class {
    func didSelect(user: User)
}

protocol UsersViewDelegate: class {
    func usersFetched()
    func errorFetchingUsers()
}

class UsersViewModel {
    weak var coordinatorDelegate: UsersCoordinatorDelegate?
    weak var viewDelegate: UsersViewDelegate?
    let usersDataManager: UsersDataManager
    var userViewModels: [UserCellViewModel] = []
    
    
    init(usersDataManager: UsersDataManager){
        self.usersDataManager = usersDataManager
    }
    
    func viewWasLoaded(){
        usersDataManager.fetchAllUsers { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let users):
                if let users = users {
                    self.userViewModels = []
                    for user in users.directoryItems {
                        let userViewModelAux = UserCellViewModel(user: user.user)
                        self.userViewModels.append(userViewModelAux)
                    }
                    
                    self.viewDelegate?.usersFetched()
                }
                
            case .failure(_):
                self.viewDelegate?.errorFetchingUsers()
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return userViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userViewModels.count else {
            return nil
        }
        return userViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < userViewModels.count else { return }
        coordinatorDelegate?.didSelect(user: userViewModels[indexPath.row].user)
        
    }
}
