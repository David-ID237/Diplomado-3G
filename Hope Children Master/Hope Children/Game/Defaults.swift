//
//  Defaults.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 8/5/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
class Defaults {
    static let shared = Defaults()
    let defaults = UserDefaults.standard
    
    func getBool(forKey : String) -> Bool{
        if defaults.object(forKey: forKey) != nil{
            return defaults.bool(forKey: forKey)
        }else {
            return true
        }
    }
    func getInt(forKey : String) -> Int{
        return defaults.integer(forKey: forKey)
    }
    func set(value : Any, key : String) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
}
