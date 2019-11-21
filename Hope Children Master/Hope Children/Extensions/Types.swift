//
//  Float+Random.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/5/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
import UIKit

extension Float{
    public static var Random: Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
    public static func Random(min: Float, max: Float) -> Float {
        return self.Random * (max - min) + min
    }
    
}

extension CGFloat{
    static func Random(min: Int , max: Int) -> CGFloat {
        return CGFloat(Float.Random(min : Float(min) , max : Float(max)) )
    }
}

extension Int {
    static func Random(min: Int , max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
    func saveDefaults(forKey : String){
        Defaults.shared.set(value: self, key: forKey)
    }
    static func loadDefaults(forKey : String) -> Int{
        return Defaults.shared.getInt(forKey: forKey)
    }
}

extension Bool {
    func saveDefaults(forKey : String){
        Defaults.shared.set(value: self, key: forKey)
    }
    static func loadDefaults(forKey : String) -> Bool{
        return Defaults.shared.getBool(forKey: forKey)
    }
}





