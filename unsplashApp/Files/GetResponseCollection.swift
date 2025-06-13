//
//  CollectionImage.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-07-05.
//

import Foundation


struct Collections: Codable {
    var id: String?
    var title: String?
    let coverPhoto: CoverPhoto?
}

struct CoverPhoto: Codable {
    let title: String?
    let id: String?
    let width: Int?
    let height: Int?
    let blur_hash: String?
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
    
    


