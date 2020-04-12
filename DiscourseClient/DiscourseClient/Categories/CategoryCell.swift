//
//  CategoryCell.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    var viewModel: CategoryCellModel? {
        didSet{
            guard let viewModel = viewModel else {return}
            textLabel?.text = viewModel.textLabelName
        }
    }
}
