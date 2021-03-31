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

let udacitySessionCreateApi = ApiDefinition<SessionRequest, SessionResponse>(
    url: baseUrl + "/v1/session",
    method: .post,
    getDecodableResponseRange: getDecodableDataRange(data:),
    
    headers: {[
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]}
)

let udacitySessionDeleteApi = ApiDefinition<NilRequest, SessionResponse>(
    url: baseUrl + "/v1/session",
    method: .delete,
    getDecodableResponseRange: getDecodableDataRange(data:),
    
    headers: {
        var headers: [String : String] = [:]
        
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        
        if let xsrfCookie = xsrfCookie {
            headers["X-XSRF-TOKEN"] = xsrfCookie.value
        }
        
        return headers
    }
)

let udacityGetUserDataApi = ApiDefinition<NilRequest, UserResponse>(
    url: baseUrl + "/v1/users/:user_id",
    method: .get,
    getDecodableResponseRange: getDecodableDataRange(data:),
    headers: { [:] }
)

let udacityGetUserLocationsApi = ApiDefinition<UserLocationRequest, UserLocationResponse>(
    url: baseUrl + "/v1/StudentLocation",
    method: .get,
    getDecodableResponseRange: { data in 0..<data.count },
    headers: { [:] }
)

