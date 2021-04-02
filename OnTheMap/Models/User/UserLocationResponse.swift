//
//  UserLocationResponse.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 29/03/21.
//

import Foundation

struct UserLocationResponse: Codable {
    let results: [UserLocation]
}

struct UserLocation: Codable {
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
}

struct PostUserLocationResponse: Codable {
    let createdAt: String
    let objectId: String
}
