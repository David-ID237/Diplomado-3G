//
//  HTTPResponse.swift
//  SuperShop
//
//  Created by David on 5/7/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation
class HTTPResponse {
    let rawResponse: HTTPURLResponse
    
    init(reponse: HTTPURLResponse) {
        self.rawResponse = reponse
    }
    
    lazy var status: Status = {
        return Status(rawValue: self.rawResponse.statusCode)
    }()
    
    func successful() -> Bool {
        return status == Status.success
    }
}
