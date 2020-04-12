//
//  SingleUserRequest.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

// TODO: Implementar las propiedades de esta request
struct SingleUserRequest: APIRequest {
    
    typealias Response = SingleUserResponse
    
    let userName: String
    
    init(userName: String) {
        self.userName = userName
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/users/\(userName).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
