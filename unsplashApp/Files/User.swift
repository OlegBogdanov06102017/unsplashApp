//
//  User.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-05-21.
//

import Foundation


enum User: String {
    case client_id
    case redirect_uri
    case response_type
   // case scope: [Scope]
    
    
}

struct Scope  {
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
