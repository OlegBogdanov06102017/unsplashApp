import Foundation

public enum CustomerAPI {
    case randomPhoto
    case collections
    case photo(page: Int)
    case topic
    case topicPhotos(slug: String)
    
    
    public var path: String {
        switch self {
        case .randomPhoto:
            "https://api.unsplash.com/photos/random"
        case .collections:
            "https://api.unsplash.com/collections"
        case .photo(let page):
            "https://api.unsplash.com/photos?page=\(page)"
        case .topic:
            "https://api.unsplash.com/topics"
        case .topicPhotos(let slug):
            "https://api.unsplash.com/topics/\(slug)/photos"
        }
    }
}

