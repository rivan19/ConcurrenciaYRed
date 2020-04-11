//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.textLabelText
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let photo = viewModel.imageString {
                    let formatURL = photo.replacingOccurrences(of: "{size}", with: "100")
                    
                    let url = URL(string: formatURL)
                    if let urlFormated = url {
                        if let data = try? Data(contentsOf: urlFormated) {
                            let image = UIImage(data: data)
                            
                            DispatchQueue.main.async { [weak self] in
                                guard let self = self else {
                                    return
                                }
                                
                                self.imageView?.image = image
                                self.setNeedsLayout()
                            }
                        }
                        
                    }

                }
                
            }
        }
    }
    
}
