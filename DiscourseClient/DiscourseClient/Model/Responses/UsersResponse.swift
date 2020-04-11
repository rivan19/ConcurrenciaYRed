//
//  UsersResponse.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UsersResponse: Codable {
    let directoryItems: [DirectoryItem]
    
    enum CodingKeys: String, CodingKey {
        case directoryItems = "directory_items"
    }
}


struct DirectoryItem: Codable {
    let user: User
}

struct User: Codable {
    let id: Int
    let userName: String
    let avatarTemplate: String
    let name: String
    
    enum CodindKeys: String, CodingKey {
        case id
        case userName = "username"
        case avatarTemplate = "avatar_template"
        case name = "name"
    }
}

