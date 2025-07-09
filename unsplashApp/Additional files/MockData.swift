import Foundation

struct MockData {
    static let shared = MockData()
    
    private var exploreSection: ListSection = {
        .explore([.init(title: "", image: "")])
    }()
    
    private var newSection: ListSection = {
        .new([.init(title: "", image: "")])
    }()
    
    var pageSectionData: [ListSection] {
        [exploreSection, newSection]
    }
}

