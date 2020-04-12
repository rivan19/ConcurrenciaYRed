//
//  SingleUserResponse.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct SingleUserResponse: Codable {
    let user: SingleUser
}

struct SingleUser: Codable {
    let id: Int
    let userName: String?
    let name: String?
    let avatarTemplate: String?
    let email: String?
    let canEdit: Bool?
    let canEditUserName: Bool?
    let canEditEmail: Bool?
    let canEditName: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "username"
        case name
        case avatarTemplate = "avatar_template"
        case email
        case canEdit = "can_edit"
        case canEditUserName = "can_edit_username"
        case canEditEmail = "can_edit_email"
        case canEditName = "can_edit_name"
    }
}
