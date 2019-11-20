//
//  Transaction.swift
//  shopapp
//
//  Created by David on 8/11/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

struct Transaction: Codable {
    let id: Int
    let identificator: String
    let status: String
    let createdAt: String?
}

struct TransactionStored: Codable {
    let transaction: Transaction
    let data: ChargeResponseData
}
