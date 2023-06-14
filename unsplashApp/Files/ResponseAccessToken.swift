//
//  ResponseAccessToken.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-09.
//

import Foundation


struct ResponseAccessToken: Decodable {
   let access_token: String
    let token_type: String = "Bearer"
    let refresh_token: String
    let scope: String = "public"
    let created_at: TimeInterval
}
