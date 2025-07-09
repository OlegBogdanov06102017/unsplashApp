import Foundation

enum ListSection {
    case explore([ListItems])
    case new([ListItems])
    
    var items: [ListItems] {
        switch self {
        case .explore(let items),
                .new(let items):
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
    
    var title: String {
        switch self {
        case .explore:
            return "Explore"
        case .new:
            return "New"
        }
    }
}


