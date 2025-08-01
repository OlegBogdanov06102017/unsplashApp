import Foundation


struct Collections: Codable {
    var id: String?
    var title: String?
    var cover_photo: CoverPhoto?
}

struct CoverPhoto: Codable {
    let title: String?
    let id: String?
    let width: Int?
    let height: Int?
    let blur_hash: String?
    let breadcrumbs: [Breadcrumbs]?
    let urls: Urls?
}

struct Urls: Codable {

    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String?
    let small_s3: String?
}

struct Breadcrumbs: Codable {
    let title: String
}
    
    


