//
//  SingleUserRequest.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

// TODO: Implementar las propiedades de esta request
struct EditSingleUserRequest: APIRequest {
    
    typealias Response = EditSingleUserResponse
    
    let userName: String
    let name: String
    
    init(userName: String, name: String) {
        self.userName = userName
        self.name = name
    }
    
    var method: Method {
        return .PUT
    }
    
    var path: String {
        return "/users/\(self.userName).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [
            "name" : self.name
        ]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
