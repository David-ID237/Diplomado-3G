//
//  PromotionClient.swift
//  shopapp
//
//  Created by David on 8/8/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

class PromotionClient: APIClient {
    
    static let shared = PromotionClient()
    
    convenience init() {
        self.init(client: Client(), path: Config.baseAPI.value! + "")
    }
    
    func list(success: @escaping ([Promotion]) -> Void) {
        get(endpoint: "/promotions", success: success)
    }
    
}
