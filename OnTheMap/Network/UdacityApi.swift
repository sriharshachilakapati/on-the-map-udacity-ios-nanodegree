//
//  UdacityApi.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 25/03/21.
//

import Foundation

let baseUrl = "https://onthemap-api.udacity.com"

let getDecodableDataRangeForUdacityApi = { (data: Data) in 5..<data.count }
let getDecodableDataRangeForParseApi   = { (data: Data) in 0..<data.count }

let udacitySessionCreateApi = ApiDefinition<SessionRequest, SessionResponse>(
    url: baseUrl + "/v1/session",
    method: .post,
    getDecodableResponseRange: getDecodableDataRangeForUdacityApi,
    
    headers: {[
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]}
)

let udacitySessionDeleteApi = ApiDefinition<NilRequest, SessionResponse>(
    url: baseUrl + "/v1/session",
    method: .delete,
    getDecodableResponseRange: getDecodableDataRangeForUdacityApi,
    
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

let userIdPathParam = ":user_id"

let udacityGetUserDataApi = ApiDefinition<NilRequest, UserResponse>(
    url: baseUrl + "/v1/users/\(userIdPathParam)",
    method: .get,
    getDecodableResponseRange: getDecodableDataRangeForUdacityApi,
    headers: { [:] }
)

let udacityGetUserLocationsApi = ApiDefinition<UserLocationRequest, UserLocationResponse>(
    url: baseUrl + "/v1/StudentLocation",
    method: .get,
    getDecodableResponseRange: getDecodableDataRangeForParseApi,
    headers: { [:] }
)

let udacityPostUserLocationApi = ApiDefinition<PostUserLocationRequest, PostUserLocationResponse>(
    url: baseUrl + "/v1/StudentLocation",
    method: .post,
    getDecodableResponseRange: getDecodableDataRangeForParseApi,
    headers: {[
        "Content-Type": "application/json"
    ]}
)
