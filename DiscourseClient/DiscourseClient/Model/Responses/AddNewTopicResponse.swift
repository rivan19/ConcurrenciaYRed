import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct AddNewTopicResponse: Codable {
    let id: Int
    let name: String
    let userName: String
    let avatarTemplates: String
    let createdAt: String
    let canEdit: Bool?
    let canDelete: Bool?
    let canRecover: Bool?
    let canWiki: Bool?
    let userTitle: String?
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case userName = "username"
        case avatarTemplates = "avatar_template"
        case createdAt = "created_at"
        case canEdit = "can_edit"
        case canDelete = "can_delete"
        case canRecover = "can_recover"
        case canWiki = "can_wiki"
        case userTitle = "user_title"
        case userId = "user_id"
    }
    
}
