//
//  JSONResponse.swift
//  SuperShop
//
//  Created by David on 5/7/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

struct JSONResponse<T>: Codable where T: Codable {
    var data: T
}
