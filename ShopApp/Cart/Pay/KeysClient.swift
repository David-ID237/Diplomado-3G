//
//  KeysClient.swift
//  shopapp
//
//  Created by David on 8/10/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

struct ContainerKey: Codable {
    let key: String?
}

class KeysClient: APIClient {
    
    static let shared = KeysClient()
    
    convenience init() {
        self.init(client: Client(), path: Config.baseAPI.value! + "")
    }
    
    func getKey(uidevice: String, success: @escaping (ContainerKey) -> Void) {
        let queryItems: [String:String] = ["uidevice": uidevice]
        get(endpoint: "/key", queryItems: queryItems, success: success)
    }
    
    
}
