//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol TopicDetailCoordinatorDelegate: class {
    func topicDetailBackButtonTapped()
    func topicRemoveButtonTapped()
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol TopicDetailViewDelegate: class {
    func topicDetailFetched(delete: Bool?)
    func errorFetchingTopicDetail()
}

class TopicDetailViewModel {
    var labelTopicIDText: String?
    var labelTopicNameText: String?
    var labelTopicTitleText: String?

    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    let topicDetailDataManager: TopicDetailDataManager
    let topicID: Int

    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }

    func viewDidLoad() {
        topicDetailDataManager.fetchTopic(id: self.topicID) {[weak self] (result) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                    case .success(let topic):
                        if let topic = topic {
                            self.labelTopicIDText = "\(topic.postStream.posts[0].id)"
                            self.labelTopicNameText = topic.postStream.posts[0].name
                            self.labelTopicTitleText = topic.postStream.posts[0].topicSlug.replacingOccurrences(of: "-", with: " ")
                            self.viewDelegate?.topicDetailFetched(delete: topic.details.canDelete)
                        }
                        else {
                            self.viewDelegate?.topicDetailFetched(delete: false)
                        }
                    
                    case .failure(_):
                        self.viewDelegate?.errorFetchingTopicDetail()
                }
            }
            
        }
    }

    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
        
    }
    
    func deleteButtonTapped() {
        
        topicDetailDataManager.deleteTopic(id: self.topicID) { [weak self] (result) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                    case .success(_):
                        self.coordinatorDelegate?.topicRemoveButtonTapped()
                    case .failure(_):
                        self.viewDelegate?.errorFetchingTopicDetail()
                }
            }
            
        }
    }
}
