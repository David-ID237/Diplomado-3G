//
//  CategoryClient.swift
//  shopapp
//
//  Created by David on 7/20/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

class CategoryClient: APIClient {
    
    static let shared = CategoryClient()
    
    convenience init() {
        self.init(client: Client(), path: Config.baseAPI.value! + "")
    }
    
    func list(success: @escaping ([Category]) -> Void) {
        get(endpoint: "/category", success: success)
    }
    
    
}
