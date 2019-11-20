//
//  Offer.swift
//  shopapp
//
//  Created by David on 8/8/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

struct Promotion: Codable {
    let id: Int
    let thumbnailUrl: String
    let productId: Int?
    let product: Product?
    let createdAt: String
    let updatedAt: String?
}
