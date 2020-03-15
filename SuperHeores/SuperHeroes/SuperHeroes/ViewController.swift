//
//  ViewController.swift
//  SuperHeroes
//
//  Created by Ivan Llopis Guardado on 12/03/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

enum superHeroesError : Error {
    case emptySuperHeroes
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var superHeroes = [SuperHeroe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SuperHeroeCell")
        
        tableView.dataSource = self
        
        fetchSuperHeroes { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let superHeroes):
                    self?.superHeroes = superHeroes
                    self?.tableView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }

    func fetchSuperHeroes (completion: @escaping (Result<[SuperHeroe], Error>) -> Void ){
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let url = URL(string: "https://api.myjson.com/bins/bvyob")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                guard let superHeroesResponse = try? JSONDecoder().decode(SuperHeroesResponse.self, from: data)  else {
                    completion(.failure(superHeroesError.emptySuperHeroes))
                    return
                }
                
                completion(.success(superHeroesResponse.superheroes))
                
                
            }
            
        }
        
        task.resume()
    }

}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuperHeroeCell", for: indexPath)
        cell.textLabel?.text = superHeroes[indexPath.row].name
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let photo = self?.superHeroes[indexPath.row].photo else {return}
            
            let url = URL(string: photo)!
            let data = try? Data(contentsOf: url)
            let image = UIImage(data: data!)
            
            DispatchQueue.main.async {
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
            
        }
        
        return cell
        
    }
    
    
}

struct SuperHeroesResponse: Codable {
    let superheroes : [SuperHeroe]
}

struct SuperHeroe: Codable {
    let name: String
    let photo: String
    let realName: String
    let height: String
    let power: String
    let abilities: String
    let groups: String
}
