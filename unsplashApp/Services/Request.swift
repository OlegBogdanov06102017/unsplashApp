//
//  ResponseType.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-05-21.
//

import Foundation

struct Request: Codable {
    let client_id: String
    let client_secret: String
    let redirect_uri: String
    var code: String
    let grant_type: String
    
}


