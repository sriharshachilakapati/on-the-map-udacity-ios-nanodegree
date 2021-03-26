//
//  SessionResponse.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 25/03/21.
//

import Foundation

struct SessionResponse: Codable {
    let account: AccountInfo
    let session: SessionInfo
}

struct AccountInfo: Codable {
    let registered: Bool
    let key: String
}

struct SessionInfo: Codable {
    let id: String
    let expiration: String
}
