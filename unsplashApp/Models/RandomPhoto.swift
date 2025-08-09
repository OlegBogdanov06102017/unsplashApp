import Foundation


public struct RandomPhoto: Codable {
    let id: String
    let blur_hash: String?
    let urls: UrlsPhoto?
    let user: User?
}

struct UrlsPhoto: Codable {
    let regular: String?
}

struct User: Codable {
    let name: String?
}
