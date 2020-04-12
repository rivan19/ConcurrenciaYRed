//
//  CategoriesViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol CategoriesViewDelegate: class {
    func categoriesFetched()
    func errorFetchingCategories()
}

/// ViewModel representando un listado de categorías
class CategoriesViewModel {
    weak var viewDelegate: CategoriesViewDelegate?
    let categoriesDataManager: CategoriesDataManager
    var categoryViewModels: [CategoryCellModel] = []
    
    init(categoriesDataManager: CategoriesDataManager){
        self.categoriesDataManager = categoriesDataManager
    }
    
    func viewWasLoaded(){
        categoriesDataManager.fetchAllCategories { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    if let categories = categories {
                        self.categoryViewModels = []
                        for category in categories.categoryList.categories {
                            let categoryViewModelAux = CategoryCellModel(category: category)
                            self.categoryViewModels.append(categoryViewModelAux)
                        }
                        
                        self.viewDelegate?.categoriesFetched()
                    }
                case .failure(_):
                    self.viewDelegate?.errorFetchingCategories()
                }
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return categoryViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> CategoryCellModel? {
        guard indexPath.row < categoryViewModels.count else {
            return nil
        }
        return categoryViewModels[indexPath.row]
    }
}
