//
//  Product.swift
//  shopapp
//
//  Created by David on 7/22/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let description: String
    let price: String
    let stock: Int
    let thumbnailUrl: String
    let tags: String
    let createdAt: String
    let category: CategoryInProduct
    var number: Int? = 1
}

struct CategoryInProduct: Codable {
    let id: Int
    let name: String
}
