//
//  ResponseType.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-05-21.
//

import Foundation

 struct TokenResponse: Decodable {
    var access_token: String
    var token_type: String
    var scope: [Grants]
    var created_at: Int
    
}

struct Grants: Decodable {
    var `public`: String
    var read_user: String
    var write_user: String
    var read_photos: String
    var write_photos: String
    var write_likes: String
    var write_followers: String
    var read_collections: String
    var write_collections: String
}


