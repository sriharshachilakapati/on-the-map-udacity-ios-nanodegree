//
//  NetworkApi.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 25/03/21.
//

import Foundation

struct ApiDefinition<RequestType: Codable, ResponseType: Codable> {
    let url: String
    let method: HttpMethod
    let getDecodableResponseRange: (Data) -> Range<Int>
    let headers: [String : String]?
    
    func call(withPayload payload: RequestType, completion: @escaping (Result<ResponseType, Error>) -> Void) {
        let url = URL(string: self.url)!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 500)
        
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        do {
            request.httpBody = try JSONEncoder().encode(payload)
        } catch {
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(Result.failure(error!))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let subsetRange = getDecodableResponseRange(data)
                let newData = data.subdata(in: subsetRange)
                let value = try decoder.decode(ResponseType.self, from: newData)
                completion(Result.success(value))
            } catch {
                completion(Result.failure(error))
            }
        }
        
        task.resume()
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
