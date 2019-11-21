//
//  GameKeys.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/30/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation

class Constant{
    static let keyTarget = "Target-"
    static let keyMissile = "Missile-"
    static let scnassets = "ar.scnassets/Models/NumbersAll.scn"
    static let assetsNumber = "Number_"
    static let spawnTime = Float.Random(min: 1.5, max: 3.0)
    
    static let keyPlay = "PlayKey"
    static let keySound = "SoundKey"
    static let keyMusic = "MusicKey"
    static let keyLastScore = "LastScoreKey"
    static let keyHighScore = "HighScoreKey"
    static let IdentifierToGame = "ToGame"
    
    static let FORMAT_SCORE = "SCORE:  %0\(4)d"
    static let FORMAT_BESTSCORE = "BEST:      %0\(4)d"
    static let TEXT_SALIR = "¿Esta segur@ de Salir?"
    static let MESSAGE_SALIR = "Al salir perdera sus datos de juego"
    static let CANCEL = "Cancelar"
    static let OUT = "Salir"
    
}
