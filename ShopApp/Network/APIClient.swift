//
//  APIClient.swift
//  SuperShop
//
//  Created by David on 5/7/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

struct Storage {
    var data: Codable?
    var message: String?
}

class APIClient {
    let client: Client
    let path: String
    
    init(client: Client, path: String) {
        self.client = client
        self.path = path
    }
    
    internal func get<T>(endpoint: String, queryItems: [String: String]?, success: @escaping (T) -> Void) where T: Codable {
        request("GET", path: "\(path)\(endpoint)", queryItems: queryItems, payloadData: nil,  successClosure: success, errorHandler: nil)
    }
    
    internal func get<T>(endpoint: String, success: @escaping (T) -> Void) where T: Codable {
        get(endpoint: endpoint, queryItems: nil, success: success)
    }
    
    internal func post<T>(payload: Data?, endpoint: String, success: @escaping (T) -> Void) where T: Codable {
        request("POST", path: "\(path)\(endpoint)", queryItems: nil, payloadData: payload, successClosure: success, errorHandler: nil)
    }

    internal func request<Model>(_ method: String, path: String, queryItems: [String: String]?, payloadData: Data?, successClosure: @escaping (Model) -> Void, errorHandler: errorHandler?) where Model:Codable {
        // let data = payload
        client.request(method, path: path, queryItems: queryItems, body: payloadData, completionHandler: { [weak self ](response, data) in
            guard let selfStrong = self else { return }
            guard response.successful() else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                guard let data = data else { print("Empty response"); return }
                let json = try decoder.decode(JSONResponse<Model>.self, from: data)
                successClosure(json.data)
            } catch let err {
                print("Unable to parse successfull response: \(err.localizedDescription)")
                errorHandler?(err)
            }
        }, errorHandler: errorHandler)
    }
    
    func generatePayload<T>(payload: T?) -> Data? where T:Codable {
        guard let payload = payload else { return nil }
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let encoded = try? encoder.encode(payload)
        return encoded
    }
    
    
}
