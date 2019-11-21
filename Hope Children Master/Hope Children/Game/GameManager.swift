//
//  GameManager.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/7/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
import ARKit
import SpriteKit

class GameManager{
    static let shared = GameManager()
    
    let timer = UITimerProgress()
    
    private let media = Media.shared
    let defaults = Defaults.shared
    let operations = Operations.shared
    
    var settingsSounds = true
    var settingsMusic = true
    
    var labelScore:UILabel
    
    var state = GameState.ToPlay
    var score:Int
    var scoreTemporal:Int = 0
    var highScore:Int
    var lastScore:Int
    
    var countSpawner:Int = 0
    var countSpawnerMax:Int = 1
    var spawnTime: TimeInterval = 0
    var level:Int = 0

    
    var operationTargets : [Int : Level] = [:]
    
    private init() {
        level = 0
        score = 0
        lastScore = 0
        highScore = 0
        scoreTemporal = 0
        
        labelScore = UILabel()
        
        score = defaults.getInt(forKey: Constant.keyLastScore)
        highScore = defaults.getInt(forKey: Constant.keyHighScore)
        settingsSounds = defaults.getBool(forKey: Constant.keySound)
        settingsMusic = defaults.getBool(forKey: Constant.keyMusic)
        
        media.setupSounds()
    }
    
    
    func updateHUD(){
        score += 1
        scoreTemporal += 1
        if(scoreTemporal >= 5){
            level += 1
            scoreTemporal = 0
        }
        let scoreFormatted = String(format: "%0\(4)d", score)
        labelScore.text = "\(scoreFormatted)"
    }
 
    func reset() {
        score = 0
        scoreTemporal = 0
        countSpawner = 0
        level = 0
    }
    
    func saveState() {
        lastScore = score
        highScore = max(score, highScore)
        
        lastScore.saveDefaults(forKey: Constant.keyLastScore)
        highScore.saveDefaults(forKey: Constant.keyHighScore)
    }

    func sound(){
        self.settingsSounds = !self.settingsSounds
        UserDefaults.standard.set(self.settingsSounds, forKey: Constant.keySound)
    }
    
    func music(){
        self.settingsMusic = !self.settingsMusic
        UserDefaults.standard.set(self.settingsMusic, forKey: Constant.keyMusic)
    }
    
    func playSound(named : String, _ node:SCNNode) {
        if !settingsSounds {
            return
        }
        self.media.play(named: named, node)
    }
    
    func playBackgroundMusic(_ rootNode : SCNNode){
        if !settingsMusic {
            return
        }
        self.media.playBackground(rootNode)
    }
    
    
    func removeBackgroundMusic(_ rootNode : SCNNode){
        self.media.removeBackgroundMusic(rootNode)
    }
}
