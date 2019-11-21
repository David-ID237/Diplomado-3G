//
//  GameViewController+ArKit.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/14/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
import ARKit

extension GameViewController :
    ARSCNViewDelegate,
    SCNSceneRendererDelegate{
    
    func sessionInit(){
        self.sceneView.showsStatistics = false
        self.sceneView.delegate = self
        self.sceneView.scene.physicsWorld.contactDelegate = self
        self.sceneView.automaticallyUpdatesLighting = true
    }
    
    func sessionARStart(){
        let configuration = ARWorldTrackingConfiguration()
        self.sceneView.session.run(configuration)
        self.gameManager.playBackgroundMusic(self.sceneView.scene.rootNode)
    }
    
    func sessionARPause(){
        self.sceneView.session.pause()
    }
    
    func sessionARResume(){
        self.sceneView.session.run(sceneView.session.configuration!)
    }
    
    func sessionARClean(){
        for node in sceneView.scene.rootNode.childNodes {
            node.removeFromParentNode()
        }
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        gameOver()
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        guard let configuration = session.configuration else {return}
        sceneView.session.run(configuration,
                              options: [.resetTracking])
    }

    //Obtiene la direccion y posicion de la camara
    func cameraVector() -> (SCNVector3, SCNVector3) { // (direction, position)
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33) // orientation of camera in world space
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // location of camera in world space
            return (dir, pos)
        }
        return (SCNVector3(0, 0, -1), SCNVector3(0, 0, -0.2))
    }
    
    //Actualiza cada tiempo
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if gameManager.state == .Playing {
            if time > gameManager.spawnTime {
                if gameManager.countSpawner < gameManager.countSpawnerMax{
                    spawnTarget()
                    gameManager.spawnTime = time + TimeInterval(Constant.spawnTime)
                }
            }
            cleanScene()
        }
    }
    
    //Limpia cuando los nodos son mayores a -10 en Z
    func cleanScene() {
        for node in sceneView.scene.rootNode.childNodes {
            if node.presentation.position.z < -10 {
                node.removeFromParentNode()
            }
        }
    }
    
    func loadNumber(named : String)->SCNNode?{
        guard let scene = SCNScene(named: Constant.scnassets), let node =  scene.rootNode.childNode(withName: named, recursively: true) else {return nil}
        return node
    }
    
    func loadNumber(number : Int)->SCNNode?{
        return loadNumber(named : "\(Constant.assetsNumber)\(number)")
    }
}
