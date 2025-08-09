import Foundation

struct TopicPhoto: Codable {
    let id: String?
    let slug: String?
    let urls: UrlTopicPhoto?
}


struct UrlTopicPhoto: Codable {
    let small: String?
}
