//
//  GameViewController+Game.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/23/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
import ARKit

extension GameViewController: SCNPhysicsContactDelegate{
    
    // MARK: Target
    func spawnTarget() {
        DispatchQueue.main.async {
            self.createTarget(id: self.gameManager.countSpawner)
            self.gameManager.countSpawner += 1
        }
    }
 
    func createTarget(id: Int){
        let panelNodeMain = SCNNode()
        
        let (position, location) = SCNVector3.random(gameManager.operationTargets)
        print("\(location)")
        guard let target = gameManager.operations.generateOperationLevel(level : gameManager.level, index: id, location: location) else {return}
        
        panelNodeMain.name = "\(Constant.keyTarget)\(target.index)"
        guard let numero1 = loadNumber(named: target.numero1.name) else {return}
        numero1.scale = SCNVector3(0.1,0.1,0.1)
        numero1.position = SCNVector3(x: position.x, y: position.y, z: position.z)
        
        guard let operador = loadNumber(named: target.operador.name) else {return}
        operador.scale = SCNVector3(0.05,0.05,0.05)
        operador.position = SCNVector3(x: position.x + 0.9, y: position.y + 0.8, z: position.z)
        
        guard let numero2 = loadNumber(named: target.numero2.name) else {return}
        numero2.scale = SCNVector3(0.1,0.1,0.1)
        numero2.position = SCNVector3(x: position.x + 1.60, y: position.y, z: position.z)
        
        guard let equals = loadNumber(named: target.equals.name) else {return}
        equals.scale = SCNVector3(0.05,0.05,0.05)
        equals.position = SCNVector3(x: position.x + 2.45, y: position.y + 0.8, z: position.z)
        
        guard let result = loadNumber(named: target.result.name) else {return}
        result.scale = SCNVector3(0.005,0.005,0.005)
        result.position = SCNVector3(x: position.x + 3.25, y: position.y, z: position.z)
        
        panelNodeMain.addChildNode(numero1)
        panelNodeMain.addChildNode(operador)
        panelNodeMain.addChildNode(numero2)
        panelNodeMain.addChildNode(equals)
        panelNodeMain.addChildNode(result)
        AddPhisicsNode(nodeParent: panelNodeMain)
        panelNodeMain.scale = SCNVector3(0.7,0.7,0.7)
        panelNodeMain.position = SCNVector3(position.x, position.y, position.z)
        panelNodeMain.name = "\(Constant.keyTarget)\(target.index)"
        gameManager.operationTargets[target.index] = target
        sceneView.scene.rootNode.addChildNode(panelNodeMain)

    }
    
    //Se agrega fisica a todos las partes de la operacion
    func AddPhisicsNode(nodeParent : SCNNode) {
        let color = UIColor.random()
        for node in nodeParent.childNodes{
            node.name = nodeParent.name
            node.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
            guard let physicsBody = node.physicsBody else {return}
            physicsBody.isAffectedByGravity = false
            physicsBody.categoryBitMask = CollisionCategory.targetCategory.rawValue
            physicsBody.contactTestBitMask = CollisionCategory.misilleCategory.rawValue
            guard let geometry = node.geometry, let material = geometry.firstMaterial else {continue}
            material.diffuse.contents = color
        }
    }
    
    // MARK: Missile
    func generateMissile(_ rawMissile : Int){
        guard let node =  loadNumber(number : rawMissile) else {return}
        
        let (directionCamera, positionCamera) = self.cameraVector()
        node.position = positionCamera
        node.scale = SCNVector3(0.03,0.03,0.03)
        node.name = "\(Constant.keyMissile)\(rawMissile)"
        node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        if let physicsBody = node.physicsBody{
            let direction = SCNVector3(directionCamera.x * 5, directionCamera.y * 5, directionCamera.z * 5)
            physicsBody.isAffectedByGravity = false
            physicsBody.categoryBitMask = CollisionCategory.misilleCategory.rawValue
            physicsBody.collisionBitMask = CollisionCategory.targetCategory.rawValue
            gameManager.playSound(named: "SpawnGood", node)
            physicsBody.applyForce(direction,  asImpulse: true)
        }
        sceneView.scene.rootNode.addChildNode(node)
        self.createMissile()
    }
    
    
    // MARK: - Contact Delegate
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        guard let physicsBodyA = contact.nodeA.physicsBody, let physicsBodyB = contact.nodeB.physicsBody else {return}
        if physicsBodyA.categoryBitMask == CollisionCategory.targetCategory.rawValue
            || physicsBodyB.categoryBitMask == CollisionCategory.targetCategory.rawValue {
            validateContact(nodeA: contact.nodeA, nodeB: contact.nodeB)
        }
    }
    
    func validateContact(nodeA : SCNNode, nodeB : SCNNode){
        var toDestroy = Destroy.Misille
        guard let answer = nodeA.name, let missile = nodeB.name else {return}
        if (!answer.contains(Constant.keyTarget) && !missile.contains(Constant.keyMissile)) {
            return
        }
        let targetIndex = answer.replace(of: Constant.keyTarget)
        let shootIndex = missile.replace(of: Constant.keyMissile)
        guard let index = Int(targetIndex),
            let target = Int(targetIndex),
            let rawTarget = gameManager.operationTargets[index] else {return}
        if shootIndex == rawTarget.result.raw{
            toDestroy = .All
        }
        DispatchQueue.main.async {
            if toDestroy == .All{
                self.handleGoodCollision(nodeA, nodeB, target)
            } else if toDestroy == .Misille{
                self.handleBadCollision(nodeA, nodeB)
            }
        }
    }
    
    func handleGoodCollision(_ nodeA : SCNNode, _ nodeB : SCNNode, _ target : Int) {
        gameManager.operationTargets.removeValue(forKey: target)
        gameManager.countSpawner -= 1
        gameManager.updateHUD()
        if let parent = nodeA.parent{
            self.removeFromParent(nodeParent: nodeB){//Se remueve Missille
                self.gameManager.playSound(named: "ExplodeGood", nodeA)
                self.addParticleSystem(named: "Explosion", node: nodeA)
                self.removeFromParent(nodeParent: parent) {}
            }
        }
    }
    
    func handleBadCollision(_ nodeA : SCNNode, _ nodeB : SCNNode) {
        self.removeFromParent(nodeParent: nodeB){
            self.gameManager.playSound(named: "ExplodeBad", nodeA)
            self.addParticleSystem(named: "ExplosionBad", node: nodeA)
        }
    }
    
    func addParticleSystem(named : String, node : SCNNode){
        let explosionNode = SCNNode()
        if let explosion = SCNParticleSystem(named: named, inDirectory: nil){
            explosionNode.position = node.position
            sceneView.scene.rootNode.addChildNode(explosionNode)
            explosionNode.addParticleSystem(explosion)
        }
    }
    
    func removeFromParent(nodeParent : SCNNode, success : @escaping () -> Void){
        nodeParent.runAction(.customAction(duration: 0.2, action: { node, progress in
            node.physicsBody = nil
            node.scale = SCNVector3(x: Float(0), y: Float(0), z: Float(0))
        })) {
            nodeParent.removeFromParentNode()
            success()
        }
    }
    
}
