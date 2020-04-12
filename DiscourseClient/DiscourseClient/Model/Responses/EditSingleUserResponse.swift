//
//  EditSingleUserResponse.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct EditSingleUserResponse: Codable {
    let success: String?
    let user: EditSingleUser
}

struct EditSingleUser: Codable {
    let id: Int?
    let userName: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "username"
        case name
    }
}
