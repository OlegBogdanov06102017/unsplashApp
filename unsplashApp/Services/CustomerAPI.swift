import Foundation

public enum CustomerAPI {
    case randomPhoto
    case collections
    case photo
    case topic
    case topicPhotos(slug: String)
    
    public var path: String {
        switch self {
        case .randomPhoto:
            "https://api.unsplash.com/photos/random"
        case .collections:
            "https://api.unsplash.com/collections"
        case .photo:
            "https://api.unsplash.com/photos"
        case .topic:
            "https://api.unsplash.com/topics"
        case .topicPhotos(let slug):
            "https://api.unsplash.com/topics/\(slug)/photos"
        }
    }
}

