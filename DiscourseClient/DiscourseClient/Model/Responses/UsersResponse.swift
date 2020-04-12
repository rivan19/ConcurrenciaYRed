//
//  UsersResponse.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UsersResponse: Codable {
    let directoryItems: [DirectoryItem]
    
    enum CodingKeys: String, CodingKey {
        case directoryItems = "directory_items"
    }
}


struct DirectoryItem: Codable {
    let id: Int?
    let likesReceived: Int?
    let likesGiven: Int?
    let topicsEntered: Int?
    let topicCount: Int?
    let postCount: Int?
    let postsRead: Int?
    let daysVisited: Int?
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case likesReceived = "likes_received"
        case likesGiven = "likes_given"
        case topicsEntered = "topics_entered"
        case topicCount = "topic_count"
        case postCount = "post_count"
        case postsRead = "posts_read"
        case daysVisited = "days_visited"
        case user
    }
}

struct User: Codable {
    let id: Int?
    let userName: String
    let avatarTemplate: String?
    let name: String?
    
     enum CodingKeys: String, CodingKey {
        case id
        case name
        case userName = "username"
        case avatarTemplate = "avatar_template"
           
       }
}

