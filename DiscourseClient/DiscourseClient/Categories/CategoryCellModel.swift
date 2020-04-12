//
//  CategoryCellModel.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class CategoryCellModel {
    let category: Category
    var textLabelId: String?
    var textLabelName: String?
    
    init(category: Category) {
        self.category = category
        self.textLabelId = "\(category.id)"
        self.textLabelName = category.name
    }
}
