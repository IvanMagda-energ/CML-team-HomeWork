
import Foundation
struct CurrentUserModel : Codable {
    let id : Int
    let email : String?
    let emailVerified : Bool?
    let firstName : String?
    let lastName : String?
    let phone : String?
    let avatar : Avatar?
    let accountId : Int
    let role : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case email = "email"
        case emailVerified = "emailVerified"
        case firstName = "firstName"
        case lastName = "lastName"
        case phone = "phone"
        case avatar = "avatar"
        case accountId = "accountId"
        case role = "role"
    }
}
struct Avatar : Codable {
    let s3Key : String?
    let s3Link : String?
    
    enum CodingKeys: String, CodingKey {
        
        case s3Key = "s3Key"
        case s3Link = "s3Link"
    }
}
