//
//  URLRequestHelpers.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 27/03/21.
//

import Foundation

extension URLRequest {
    mutating func setQueryParameters(_ params: [String: Any]) {
        guard var urlComponents = URLComponents(string: url!.absoluteString) else { return }
        
        urlComponents.queryItems = params.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        
        url = urlComponents.url
    }
}
