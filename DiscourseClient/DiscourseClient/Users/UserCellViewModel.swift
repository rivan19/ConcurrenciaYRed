//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class UserCellViewModel {
    let user: User
    var textLabelText: String?
    var imageString: String?
    
    init(user: User){
        self.user = user
        self.textLabelText = user.name
        self.imageString = user.avatarTemplate
    }
}
