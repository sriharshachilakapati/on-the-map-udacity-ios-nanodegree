//
//  UserResponse.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 29/03/21.
//

import Foundation

struct UserResponse: Codable {
    let firstName: String
    let lastName: String
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case key
    }
}
