import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct SingleTopicResponse: Codable {
    let postStream: Posts
    let details: Details
    
    enum CodingKeys: String, CodingKey{
        case postStream = "post_stream"
        case details
    }
}

struct Posts: Codable {
    let posts: [Post]
}

struct Post: Codable {
    let id: Int
    let name: String
    let userName: String
    let avatarTemplate: String
    let cooked: String
    let updatedAt: String
    let postNumer: Int
    let reads: Int
    let yours: Bool?
    let topicId: Int
    let topicSlug: String
    let displayUserName: String
    let canEdit: Bool?
    let canDelete: Bool?
    let canRecover: Bool?
    let canWiki: Bool?
    let read: Bool?
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case userName = "username"
        case avatarTemplate = "avatar_template"
        case cooked
        case updatedAt = "updated_at"
        case postNumer = "post_number"
        case reads
        case yours
        case topicId = "topic_id"
        case topicSlug = "topic_slug"
        case displayUserName = "display_username"
        case canEdit = "can_edit"
        case canDelete = "can_delete"
        case canRecover = "can_recover"
        case canWiki = "can_wiki"
        case read
        case userId = "user_id"
    }
}

struct Details: Codable {
    let canEdit: Bool?
    let canDelete: Bool?
    let canCreatePost: Bool?
    let canReplyAsNewTopic: Bool?
    let canFlagTopic: Bool?
    
    enum CodingKeys: String, CodingKey {
        case canEdit = "can_edit"
        case canDelete = "can_delete"
        case canCreatePost = "can_create_post"
        case canReplyAsNewTopic = "can_reply_as_new_topic"
        case canFlagTopic = "can_flag_topic"
    }
}
