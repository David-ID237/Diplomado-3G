//
//  Category.swift
//  shopapp
//
//  Created by David on 7/20/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
    let thumbnailUrl: String
    let createdAt: String
    let updatedAt: String?
}
