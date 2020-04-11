//
//  TopicDetailViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa el detalle de un Topic
class TopicDetailViewController: UIViewController {

    lazy var labelTopicID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelTopicTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var textFieldTopicDetail: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEditable = false
        textField.font = UIFont.systemFont(ofSize: 15)
        
        return textField
    }()
    
    lazy var topicIDStackView: UIStackView = {
        let labelTopicIDTitle = UILabel()
        labelTopicIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicIDTitle.text = NSLocalizedString("Topic ID: ", comment: "")
        labelTopicIDTitle.textColor = .black

        let topicIDStackView = UIStackView(arrangedSubviews: [labelTopicIDTitle, labelTopicID])
        topicIDStackView.translatesAutoresizingMaskIntoConstraints = false
        topicIDStackView.axis = .horizontal

        return topicIDStackView
    }()

    lazy var topicNameStackView: UIStackView = {
        let labelTopicTitleTitle = UILabel()
        labelTopicTitleTitle.text = NSLocalizedString("Topic name: ", comment: "")
        labelTopicTitleTitle.translatesAutoresizingMaskIntoConstraints = false

        let topicNameStackView = UIStackView(arrangedSubviews: [labelTopicTitleTitle, labelTopicTitle])
        topicNameStackView.translatesAutoresizingMaskIntoConstraints = false
        topicNameStackView.axis = .horizontal

        return topicNameStackView
    }()
    
    lazy var topicDetailTextTitleStackView: UIStackView = {
        let labelTopicDetailText = UILabel()
        labelTopicDetailText.text = NSLocalizedString("Topic detail: ", comment: "")
        labelTopicDetailText.translatesAutoresizingMaskIntoConstraints = false
        
        let topicDetailTextTitleStackView = UIStackView(arrangedSubviews: [labelTopicDetailText])
        topicDetailTextTitleStackView.translatesAutoresizingMaskIntoConstraints = false
        topicDetailTextTitleStackView.axis = .horizontal
        
        return topicDetailTextTitleStackView
    }()
    
    lazy var topicDetailTextStackView: UIStackView = {
        let topicDetailTextStackView = UIStackView(arrangedSubviews: [textFieldTopicDetail])
        topicDetailTextStackView.translatesAutoresizingMaskIntoConstraints = false
        topicDetailTextStackView.axis = .horizontal
        
        return topicDetailTextStackView
    }()

    let viewModel: TopicDetailViewModel

    init(viewModel: TopicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(topicIDStackView)
        NSLayoutConstraint.activate([
            topicIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(topicNameStackView)
        NSLayoutConstraint.activate([
            topicNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicNameStackView.topAnchor.constraint(equalTo: topicIDStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(topicDetailTextTitleStackView)
        NSLayoutConstraint.activate([
            topicDetailTextTitleStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicDetailTextTitleStackView.topAnchor.constraint(equalTo: topicNameStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(topicDetailTextStackView)
        NSLayoutConstraint.activate([
            topicDetailTextStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicDetailTextStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 8),
            topicDetailTextStackView.topAnchor.constraint(equalTo: topicDetailTextTitleStackView.bottomAnchor, constant: 8),
            topicDetailTextStackView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -20)
        ])

        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonTapped))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    @objc func deleteButtonTapped() {
        viewModel.deleteButtonTapped()
    }

    fileprivate func showErrorFetchingTopicDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topic detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }

    fileprivate func updateUI(delete: Bool?) {
        labelTopicID.text = viewModel.labelTopicIDText
        labelTopicTitle.text = viewModel.labelTopicNameText
        textFieldTopicDetail.text = viewModel.labelTopicTitleText
        
        if let delete = delete {
            if delete == false {
                navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
        else{
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}

extension TopicDetailViewController: TopicDetailViewDelegate {
    func topicDetailFetched(delete: Bool?) {
        updateUI(delete: delete)
    }

    func errorFetchingTopicDetail() {
        showErrorFetchingTopicDetailAlert()
    }
}
