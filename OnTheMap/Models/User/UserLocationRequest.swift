//
//  UserLocationRequest.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 29/03/21.
//

import Foundation

struct UserLocationRequest: Codable {
    let limit: Int?
    let skip: Int?
    let uniqueKey: String?
    let order: String?
}

struct PostUserLocationRequest: Codable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
}
