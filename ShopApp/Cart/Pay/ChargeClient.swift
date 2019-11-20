//
//  ChargeClient.swift
//  shopapp
//
//  Created by David on 8/11/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

class ChargeClient: APIClient {
    
    static let shared = ChargeClient()
    
    convenience init() {
        self.init(client: Client(), path: Config.baseAPI.value! + "")
    }
    
    func post(payload: ChargeRequest, success: @escaping (ChargeResponse) -> Void) {
        post(payload: generatePayload(payload: payload), endpoint: "/charge", success: success)
    }
    
    
}
