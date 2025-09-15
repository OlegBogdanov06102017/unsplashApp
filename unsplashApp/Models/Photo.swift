import Foundation

struct Photo: Codable {
    let id: String
    let urls: UrlsForListPhoto
    
}

struct UrlsForListPhoto: Codable {
    let regular: String
}
