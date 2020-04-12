//
//  CategoriesRequest.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UserRequest: APIRequest {
    typealias Response = UsersResponse
    
    var method: Method{
        return .GET
    }
    
    var path: String{
        return "/directory_items.json"
    }
    
    var parameters: [String : String] {
        return [
            "period" : "daily",
            "order" : "likes_received"
        ]
    }
    
    var body: [String : Any]{
        return [:]
    }
    
    var headers: [String : String]{
        return [:]
    }
    
}
