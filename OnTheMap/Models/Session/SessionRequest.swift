//
//  LoginCredentials.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 25/03/21.
//

import Foundation

struct SessionRequest: Codable {
    let udacity: SessionRequestContents
    
    init(userName: String, password: String) {
        udacity = SessionRequestContents(userName: userName, password: password)
    }
}

struct SessionRequestContents: Codable {
    let userName: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case password
    }
}
