//
//  GameManager+Media.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 8/1/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//
import ARKit

class Media{
    
    static let shared = Media()
    
    var sounds:[String:SCNAudioSource] = [:]
    
    func setupSounds() {
        loadSound("ExplodeGood", fileNamed: "ar.scnassets/Sounds/ExplodeGood.wav")
        loadSound("SpawnGood", fileNamed: "ar.scnassets/Sounds/SpawnGood.wav")
        loadSound("ExplodeBad", fileNamed: "ar.scnassets/Sounds/ExplodeBad.wav")
        loadSound("GameOver", fileNamed: "ar.scnassets/Sounds/GameOver.wav")
        loadSound("Pixel", fileNamed: "ar.scnassets/Sounds/Pixel.mp3")
        loadSound("Over", fileNamed: "ar.scnassets/Sounds/over.mp3")
        
    }
    
    func loadSound(_ name:String, fileNamed:String) {
        if let sound = SCNAudioSource(fileNamed: fileNamed) {
            sound.load()
            sounds[name] = sound
        }
    }
    func play(named : String, _ node:SCNNode) {
        guard let sound = sounds[named] else {return}
        node.runAction(SCNAction.playAudio(sound, waitForCompletion: false))
    }
    
    
    
    func playBackground(_ rootNode : SCNNode){
        let audioNode = SCNNode()
        audioNode.name = "Pixel"
        guard let audioSource = sounds["Pixel"] else {return}
        let audioPlayer = SCNAudioPlayer(source: audioSource)
        audioNode.addAudioPlayer(audioPlayer)
        let play = SCNAction.playAudio(audioSource, waitForCompletion: true)
        audioNode.runAction(play, completionHandler: {
            self.playBackground(rootNode)
        })
        rootNode.addChildNode(audioNode)
    }
    
    func removeBackgroundMusic(_ rootNode : SCNNode){
        for node in  rootNode.childNodes{
            if node.name == "Pixel"{
                node.removeFromParentNode()
            }
        }
    }
}
