//
//  UserDetailViewController.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    lazy var labelUserID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textFieldUserName: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 15
        textField.isEditable = false
        textField.font = UIFont.systemFont(ofSize: 15)
        
        return textField
    }()
    
    lazy var userIDStackView: UIStackView = {
        let labelUserIDTitle = UILabel()
        labelUserIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserIDTitle.text = NSLocalizedString("User ID:", comment: "")
        labelUserIDTitle.textColor = .black
        
        let UserIDStackView = UIStackView(arrangedSubviews: [labelUserIDTitle, labelUserID])
        UserIDStackView.translatesAutoresizingMaskIntoConstraints = false
        UserIDStackView.axis = .horizontal
        
        return UserIDStackView
    }()
    
    lazy var userNameStackView: UIStackView = {
        let labelUserDetailText = UILabel()
        labelUserDetailText.text = NSLocalizedString("Name:", comment: "")
        labelUserDetailText.translatesAutoresizingMaskIntoConstraints = false
        
        let labelDetailTextNameStackView = UIStackView(arrangedSubviews: [labelUserDetailText])
        labelDetailTextNameStackView.translatesAutoresizingMaskIntoConstraints = false
        labelDetailTextNameStackView.axis = .horizontal
        
        return labelDetailTextNameStackView
    }()
    
    lazy var userNameTextStackView: UIStackView = {
        let userDetailTextStackView = UIStackView(arrangedSubviews: [textFieldUserName])
        userDetailTextStackView.translatesAutoresizingMaskIntoConstraints = false
        userDetailTextStackView.axis = .horizontal
        
        return userDetailTextStackView
    }()
    
    let viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(userIDStackView)
        NSLayoutConstraint.activate([
            userIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        view.addSubview(userNameStackView)
         NSLayoutConstraint.activate([
            userNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameStackView.topAnchor.constraint(equalTo: userIDStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(userNameTextStackView)
        NSLayoutConstraint.activate([
            userNameTextStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameTextStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            userNameTextStackView.topAnchor.constraint(equalTo: userNameStackView.bottomAnchor, constant: 8),
            userNameTextStackView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: self, action: #selector(editButtonTapped))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    @objc func backButtonTapped(){
        viewModel.backButtonTapped()
    }
    
    @objc func editButtonTapped(){
        if self.textFieldUserName.text.count > 0, !self.textFieldUserName.text.isEmpty {
            viewModel.updateButtonTapped(newName: self.textFieldUserName.text)
        }
        
    }

    
    fileprivate func showErrorFetchingUserDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error Fetching User\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func updateUI(update: Bool?) {
        labelUserID.text = viewModel.laberUserIDText
        textFieldUserName.text = viewModel.labelUserNameText
        
        if let update = update {
            
            navigationItem.rightBarButtonItem?.isEnabled = update
            self.textFieldUserName.isEditable = update
            
            
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    fileprivate func showAlertWithCompletion(_ alertMessage: String,
                               _ alertTitle: String = NSLocalizedString("Error", comment: ""),
                               _ alertActionTitle: String = NSLocalizedString("OK", comment: "")) {

        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        //alertController.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: { [weak self] (action) in
            guard let self = self else {
                return
            }
            self.viewModel.backEditedFinish()
            
        }))
        present(alertController, animated: true, completion: nil)
    }
}

extension UserDetailViewController: UserDetailViewDelegate {
    func userDetailFetched(update: Bool?) {
        updateUI(update: update)
    }
    
    func errorFetchingUserDetail() {
        showErrorFetchingUserDetailAlert()
    }
    
    func userEdited(update: Bool, message: String, alertTitle: String, alertActionTitle: String) {
        showAlertWithCompletion(message, alertTitle, alertActionTitle)
        
    }
}
