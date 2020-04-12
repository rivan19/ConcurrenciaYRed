//
//  CategoriesResponse.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct CategoriesResponse: Codable {
    let categoryList: CategoryList
    
    enum CodingKeys: String, CodingKey{
        case categoryList = "category_list"
    }
}

struct CategoryList: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let id: Int
    let name: String
}
