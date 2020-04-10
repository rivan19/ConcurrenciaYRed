import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct LatestTopicsResponse: Codable {
    let topicList: TopicList
    
    enum CodingKeys: String, CodingKey{
        case topicList = "topic_list"
    }
}

struct TopicList: Codable {
    let canCreateTopic: Bool
    let topics: [Topic]
    
    enum CodingKeys: String, CodingKey{
        case canCreateTopic = "can_create_topic"
        case topics
    }
}

struct Topic: Codable {
    let id: Int
    let title: String
    let fancyTitle: String
    let slug: String
    let postsCount: Int
    let replyCount: Int
    let highestPostNumber: Int
    let imageUrl: String?
    let createdAt: String
    let unSeen: Bool?
    let pinned: Bool?
    let unPinned: Bool?
    let visible: Bool?
    let closed: Bool?
    let archived: Bool?
    let lastPosterUserName: String
    let posters: [Poster]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case fancyTitle = "fancy_title"
        case slug
        case postsCount = "posts_count"
        case replyCount = "reply_count"
        case highestPostNumber = "highest_post_number"
        case imageUrl = "image_url"
        case createdAt = "created_at"
        case unSeen = "unseen"
        case pinned
        case unPinned = "unpinned"
        case visible
        case closed
        case archived
        case lastPosterUserName = "last_poster_username"
        case posters
    }
}

struct Poster: Codable {
    let extras: String?
    let description: String
    let userId: Int
    
    enum CodingKeys: String, CodingKey{
        case extras
        case description
        case userId = "user_id"
    }
    
}
