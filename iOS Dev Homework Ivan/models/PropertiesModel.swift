
import Foundation

struct PropertiesModel : Codable {
    let data : [PropertyData]
    let total : Int
    let totalPages : Int

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case total = "total"
        case totalPages = "totalPages"
    }
}

struct PropertyData : Codable {
    let id : Int
    let name : String?
    let description : String?
    let country : String
    let zipCode : String?
    let state : String?
    let district : String?
    let city : String
    let street : String
    let houseNumber : String?
    let suiteNumber : String?
    let coordinates : Coordinates?
    let type : String?
    let status : String?
    let account : String?
    let imageS3Array : [ImageS3Array]?
    let code : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case country = "country"
        case zipCode = "zipCode"
        case state = "state"
        case district = "district"
        case city = "city"
        case street = "street"
        case houseNumber = "houseNumber"
        case suiteNumber = "suiteNumber"
        case coordinates = "coordinates"
        case type = "type"
        case status = "status"
        case account = "account"
        case imageS3Array = "imageS3Array"
        case code = "code"
    }
}

struct Coordinates : Codable {
    let lat : String?
    let lng : String?

    enum CodingKeys: String, CodingKey {

        case lat = "lat"
        case lng = "lng"
    }
}

struct ImageS3Array : Codable {
    let key : String?
    let temporaryLink : String?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case key = "key"
        case temporaryLink = "temporaryLink"
        case description = "description"
    }
}
