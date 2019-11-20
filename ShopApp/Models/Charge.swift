//
//  ShopCart.swift
//  shopapp
//
//  Created by David on 8/10/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

struct ChargeRequest: Codable {
    let uidevice: String
    let data: String// Encoded data (ShopCartStruc)
}

struct ChargeResponse: Codable {
    let success: Bool
    let message: String
    let transaction: Transaction?
    let charge: ChargeResponseData?
}

struct ChargeResponseData: Codable {
    let products: [Product]
    let amount: Float
    let directionAlias: String
}


struct ChargeData: Codable {
    let products: [Product]
    let amount: Float
    let creditCard: CreditCard
    let direction: Direction
}

extension ChargeData {
    private func toJSON() -> String {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        do {
            let jsonData = try encoder.encode(self)
            guard let jsonString = String(data: jsonData, encoding: .utf8) else { return ""}
            return jsonString
        } catch {
            return ""
        }
    }
    
    func cipherJSON(key: String) -> String? {
        let cipherData: String?
        let dataJson = self.toJSON()
        do {
            let aes = try AES(keyString: key)
            
            let encryptedData: Data = try aes.encrypt(dataJson)
            cipherData = encryptedData.base64EncodedString()
        } catch {
            print("Problem with crypt: ", error)
            cipherData = nil
        }
        return cipherData
    }
    
}

struct CreditCard: Codable {
    let holder: String
    let number: String
    let monthExpiration: String
    let yearExpiration: String
}
