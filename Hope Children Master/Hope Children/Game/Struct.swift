//
//  GameStruct.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 8/1/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation


public enum GameState {
    case Playing
    case ToPlay
    case GameOver
}

public enum Destroy {
    case All
    case Misille
    case None
}

struct Number {
    let value : Int
    let name : String
    let raw : String
    init(value : Int, name : String, raw : String) {
        self.value = value
        self.name = name
        self.raw = raw
    }
    init(value : Int, name : String, raw : Int) {
        self.value = value
        self.name = name
        self.raw = "\(raw)"
    }
    init(value : Int, raw : Int) {
        self.value = value
        self.name = "\(Constant.assetsNumber)\(value)"
        self.raw = "\(raw)"
    }
    init(value : Int) {
        self.value = value
        self.name = "\(Constant.assetsNumber)\(value)"
        self.raw = "\(value)"
    }
}

struct CollisionCategory: OptionSet {
    let rawValue: Int
    static let misilleCategory  = CollisionCategory(rawValue: 1 << 0)
    static let targetCategory   = CollisionCategory(rawValue: 1 << 1)
    static let otherCategory    = CollisionCategory(rawValue: 1 << 2)
}

struct Level{
    let index : Int
    let numero1  : Number
    let operador : Number
    let numero2 : Number
    let equals  : Number
    let result  : Number
    var location : Int//Valor entre 0-8
    // 0 -- 1 -- 2
    // 3 -- 4 -- 5
    // 6 -- 7 -- 8
}

