//
//  ResponseGetRandomPhoto.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-26.
//

import Foundation


struct ResponseGetRandomPhoto: Codable {
    let id: String
    let blur_hash: String?
    let urls: UrlsPhoto?
    let name: Name?
}

struct UrlsPhoto: Codable {
    let raw: String?
}

struct Name: Codable {
    let name: String?
}
