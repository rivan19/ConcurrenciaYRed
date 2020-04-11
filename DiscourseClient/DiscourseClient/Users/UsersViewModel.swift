//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation


protocol UsersViewDelegate: class {
    func usersFetched()
    func errorFetchingUsers()
}

class UsersViewModel {
    weak var viewDelegate: UsersViewDelegate?
    let usersDataManager: UsersDataManager
    var userViewModels: [UserCellViewModel] = []
    
    
    init(usersDataManager: UsersDataManager){
        self.usersDataManager = usersDataManager
    }
    
    func viewWasLoaded(){
        
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
        
    }
}
