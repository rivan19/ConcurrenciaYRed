//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation


protocol UserDetailCoordinatorDelegate: class {
    func userDetailBackButtonTapped()
    func updateUserButtonTapped()
    
}

protocol UserDetailViewDelegate: class {
    func userDetailFetched(update: Bool?)
    func userEdited(update: Bool, message: String, alertTitle: String, alertActionTitle: String)
    func errorFetchingUserDetail()
}


class UserDetailViewModel {
    var laberUserIDText: String?
    var labelUserNameText: String?
    
    
    weak var viewDelegate: UserDetailViewDelegate?
    weak var coordinatorDelegate: UserDetailCoordinatorDelegate?
    let userDetailDataManager: UserDetailDataManager
    let userName: String
    
    init(userName: String, userDetailDataManager: UserDetailDataManager){
        self.userName = userName
        self.userDetailDataManager = userDetailDataManager
    }
    
    func viewDidLoad(){
        userDetailDataManager.fetchUser(userName: self.userName) { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                    case .success(let singleUser):
                        if let singleUser = singleUser {
                            self.laberUserIDText = singleUser.user.userName
                            self.labelUserNameText = singleUser.user.name
                            
                            self.viewDelegate?.userDetailFetched(update: singleUser.user.canEditName)
                            
                        } else {
                            self.viewDelegate?.userDetailFetched(update: false)
                    }
                    case .failure(_):
                        self.viewDelegate?.errorFetchingUserDetail()
                }
            }
        }
    }
    
    func updateButtonTapped(newName: String) {
        userDetailDataManager.editUser(userName: self.userName, name: newName) {[weak self] (result) in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                switch result {
                    case .success(let userEdited):
                        if let userEdited = userEdited {
                            if userEdited.success?.lowercased() == "ok" {
                                self.viewDelegate?.userEdited(update: true, message: "Modificado Correctamente", alertTitle: "SUCCESS", alertActionTitle: "OK")
                            } else {
                                self.viewDelegate?.userEdited(update: false, message: "Ha Ocurrido un Problema.", alertTitle: "ERROR", alertActionTitle: "OK")
                            }
                    }
                    case .failure(_):
                        self.viewDelegate?.userEdited(update: false, message: "Ha Ocurrido un Problema.", alertTitle: "ERROR", alertActionTitle: "OK")
                }
            }
        }
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.userDetailBackButtonTapped()
    }
    
    func backEditedFinish(){
        coordinatorDelegate?.updateUserButtonTapped()
    }
    
}
