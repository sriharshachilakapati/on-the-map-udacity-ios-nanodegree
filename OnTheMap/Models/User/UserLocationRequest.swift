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
}
