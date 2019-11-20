//
//  Config.swift
//  shopapp
//
//  Created by David on 7/20/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

import Foundation

enum Config {
    
    case host
    case baseAPI
    
    var value: String? {
        switch self {
            case .host:
                return "https://shop-app-ios.herokuapp.com"
            case .baseAPI:
                return "/api"
        }
    }
    
}
