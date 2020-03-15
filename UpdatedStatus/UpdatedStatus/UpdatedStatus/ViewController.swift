//
//  ViewController.swift
//  UpdatedStatus
//
//  Created by Ivan Llopis Guardado on 13/03/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func updateTopicButtonTapped(_ sender: Any) {
        guard let updateStatusURL = URL(string: "https://mdiscourse.keepcoding.io/t/244/status") else {
            return
        }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        var request = URLRequest(url: updateStatusURL)
        request.httpMethod = "PUT"
        request.addValue("699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a", forHTTPHeaderField: "Api-Key")
        request.addValue("rivan19", forHTTPHeaderField: "Api-Username")
        
        let body: [String: Any] = [
            "status" : "archived",
            "enabled" : true,
            "until" : "2020-6-6"
        ]
        
        guard let dataBody = try? JSONSerialization.data(withJSONObject: body) else {
            return
        }
        
        request.httpBody = dataBody
        
        let dataTask = session.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showErrorAlert(title: "ERROR", message: error.localizedDescription)
                }
                return
                
            }
            
            if let data = data {
                guard let response = try? JSONDecoder().decode(UpdateStatusReponse.self, from: data) else {
                    DispatchQueue.main.async { [weak self] in
                        self?.showErrorAlert(title: "ERROR", message: "Empty Data")
                    }
                    return
                }
                
                if response.sucess.lowercased() == "ok" {
                    DispatchQueue.main.async {
                        self?.showErrorAlert(title: "SUCCESS", message: "OK")
                    }
                }
            }
            
            
        }
        
        dataTask.resume()
        
    }
    
    func showErrorAlert(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    

}

struct UpdateStatusReponse: Codable {
    let sucess: String
}
