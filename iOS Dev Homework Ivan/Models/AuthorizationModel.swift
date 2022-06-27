
import Foundation
struct AuthorizationModel: Codable {
	let accessToken: String
	let tokenType: String

	enum CodingKeys: String, CodingKey {

		case accessToken = "accessToken"
		case tokenType = "tokenType"
	}

}
