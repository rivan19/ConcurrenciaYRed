//
//  ViewController.swift
//  Categories
//
//  Created by Ivan Llopis Guardado on 12/03/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

enum CategoriesError: Error {
    case mailFormedURL
    case emptyData
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.dataSource = self
        
        fetchCategories { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let categories):
                self?.categories = categories
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        // API_KEY: 699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a
        guard let categoriesURL = URL(string: "https://mdiscourse.keepcoding.io/categories.json") else {
            completion(.failure(CategoriesError.mailFormedURL))
            return
        }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        var request = URLRequest(url: categoriesURL)
        request.httpMethod = "GET"
        request.addValue("699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a", forHTTPHeaderField: "Api-Key")
        request.addValue("rivan19", forHTTPHeaderField: "Api-Username")
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }

                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure((CategoriesError.emptyData)))
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.categoryList.categories))
                }
                return
            } catch(let error) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }
        
        dataTask.resume()
    }

}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    
}


struct CategoriesResponse: Codable {
    
    let categoryList: CategoryList
    
    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

struct CategoryList: Codable {
    let canCreateCategory:Bool
    let canCreateTopic: Bool
    let draft: Bool?
    let draftKey: String
    let draftSequence: Int
    let categories: [Category]
    
    enum CodingKeys: String, CodingKey {
        case canCreateCategory = "can_create_category"
        case canCreateTopic = "can_create_topic"
        case draft 
        case draftKey = "draft_key"
        case draftSequence = "draft_sequence"
        case categories
    }
    
}

struct Category: Codable {
    let name: String
}


