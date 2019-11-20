//
//  User.swift
//  EvaluateGM
//
//  Created by José Antonio Arellano Mendoza on 6/12/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import Foundation
import UIKit

struct User: Comparable {
    var name: String
    var lastName: String
    var email: String
    var password: String
    var isSupervisor: Bool
    var userId: String = ""
    var averageIndicator: Bool = true
    var averageArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (averageArray.reduce(0,+) / Float(averageArray.count))) {
                    averageIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (averageArray.reduce(0,+) / Float(averageArray.count))) {
                    averageIndicator = true
                } else {
                    averageIndicator = false
                }
            } else {
                averageIndicator = true
            }
        }
    }
    var hasEvaluated: Bool {
        if averageArray.count == 0 {
            return false
        } else {
            return true
        }
    }
    
    func getGeneralAverage() -> Float {
        if averageArray.count == 0 {
            return 0.0
        } else {
            return averageArray.reduce(0, +) / Float(averageArray.count)
        }
    }
    
    static func < (lhs: User, rhs: User) -> Bool {
        return rhs.getGeneralAverage() < lhs.getGeneralAverage()
    }
    
    init(name: String, lastName: String, email: String, password: String, isSupervisor: Bool) {
        self.name = name
        self.lastName = lastName
        self.email = email
        self.password = password
        self.isSupervisor = isSupervisor
    }
}
