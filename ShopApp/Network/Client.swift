//
//  Client.swift
//  SuperShop
//
//  Created by David on 5/6/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation
import UIKit

typealias completionHandler = (HTTPResponse, Data?) -> Void
typealias errorHandler = (Error?) -> Void

struct Client {
    let baseURLComponents: URLComponents
    public var accept = "application/json"
    public var contentType = "application/json"
    
    init() {
        self.baseURLComponents = URLComponents(string: Config.host.value!)!
    }
    
    func request(_ method: String, path: String, body: Data?, completionHandler: completionHandler?, errorHandler: errorHandler?) {
        request(method, path: path, queryItems: nil, body: body, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func
        request(_ method: String, path: String, queryItems: [String: String]?, body: Data?, completionHandler: completionHandler?, errorHandler: errorHandler?) {
        var requestURLComponents = baseURLComponents
        requestURLComponents.path = path
        requestURLComponents.queryItems = castQueryItems(queryItems: queryItems)
        
        guard let url = requestURLComponents.url else {
            print("[ERROR] Invalid path: \(path)")
            return
        }
        var request = URLRequest(url: url)
        request.setValue(accept, forHTTPHeaderField: "Accept")
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        request.httpBody = body
        //print("Data send request:", String(decoding: body ?? Data(), as: UTF8.self))
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                //print("Error", error)
                errorHandler?(error)
                return
            }
            let response = HTTPResponse(reponse: response as! HTTPURLResponse)
            DispatchQueue.main.async {
                if let dataDebug = data, let stringD = String(data: dataDebug, encoding: .utf8) {
                    //print("Data response: ", dataDebug, stringD)
                }
                completionHandler?(response, data)
            }
        }
        task.resume()
    }
    
    private func castQueryItems(queryItems: [String:String]?) -> [URLQueryItem] {
        guard let rawItems = queryItems, !rawItems.isEmpty else { return [] }
        var items = [URLQueryItem]()
        for (key, value) in rawItems {
            items.append(URLQueryItem(name: key, value: value))
        }
        return items
    }
    
}
