//
//  UdacityApi.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 25/03/21.
//

import Foundation

let baseUrl = "https://onthemap-api.udacity.com"

func getDecodableDataRange(data: Data) -> Range<Int> {
    return 5..<data.count
}

let udacitySessionApi = ApiDefinition<SessionRequest, SessionResponse>(
    url: baseUrl + "/v1/session",
    method: .post,
    getDecodableResponseRange: getDecodableDataRange(data:),
    
    headers: [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
)
