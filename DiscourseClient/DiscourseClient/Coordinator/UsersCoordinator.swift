//
//  UsersCoordinator.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersCoordinator: Coordinator {
    let presenter: UINavigationController
    let usersDataManager: UsersDataManager
    var usersViewModel: UsersViewModel?
    
    init(presenter: UINavigationController, usersDataManager: UsersDataManager){
        
        self.presenter = presenter
        self.usersDataManager = usersDataManager
    }
    
    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.title = NSLocalizedString("Users", comment: "")
        usersViewModel.viewDelegate = usersViewController
        usersViewModel.coordinatorDelegate = self
        self.usersViewModel = usersViewModel
        presenter.pushViewController(usersViewController, animated: false)
        
    }
    
    override func finish() {
        
    }
}

extension UsersCoordinator: UsersCoordinatorDelegate {
    func didSelect(user: User) {
        
    }
}
