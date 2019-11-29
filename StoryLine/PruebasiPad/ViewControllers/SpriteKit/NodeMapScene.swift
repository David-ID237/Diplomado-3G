//
//  NodeMapScene.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 8/3/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import RealmSwift //Para acceder a los datos de las historias
import SpriteKit

class NodeMapScene: SKScene {
    
    let mainNodeColor = "light green node"
    let childNodeColor = "yellow node"
    let creationNodeColor = "purple node"
    let returnArrow = "arrow"
    let editImage = "pencil"
    
    private var label : SKLabelNode?
    private var node : SKSpriteNode?
    var storyId: String? //The story uuid we selected on the collection view is injected here.
    
    var storyLabel = SKLabelNode(fontNamed: "HelveticaNeue-Thin")
    let realm = try! Realm()
    
    // Tree Navigation Variables:
    var visitedNodes: [String] = []
    var actualChildren: [String] = []
    var actualNode: SKSpriteNode?
    
    // Ease of manageability variables
    var nodesOnDisplay: [SKNode] = []
    var childDrawn = 0
    
    // Reference types
    var gameVCReference: GameViewController?
    
    // MARK: - Override Functions
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "story background")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        addChild(background)
        
        // Get access to Story so we can build the UI
        let story = realm.objects(Story.self).filter(NSPredicate(format: "uuid CONTAINS %@", self.storyId!)).first //Query to get story based on the id
        storyLabel.fontSize = 50
        storyLabel.position = CGPoint(x: 20, y: 20)
        storyLabel.text = story?.storyName ?? " "
        storyLabel.zPosition = 1
        storyLabel.horizontalAlignmentMode = .left
        addChild(storyLabel)
        
        //addEmitter() //Laaaag

        spawnAsRootNode(node: story!.root!)
        displayCreationNode()
        displayReturnArrow()
        
        }
    
    // MARK: - Utility Functions
    
    func displayReturnArrow(){
        let returnArrowNode = SKSpriteNode(imageNamed: returnArrow)
        returnArrowNode.position = CGPoint(x: 40, y: 80)
        returnArrowNode.size = CGSize(width: 50, height: 50)
        returnArrowNode.zRotation = CGFloat(Double.pi / 2)
        returnArrowNode.name = "returnNode"
        addChild(returnArrowNode)
    }
    
    func displayCreationNode(){
        let creationNode = SKSpriteNode(imageNamed: creationNodeColor)
        creationNode.position = CGPoint(x: size.width - 100, y: 100)
        creationNode.size = CGSize(width: 100, height: 100)
        
        let nodeName = SKLabelNode(text: "+")
        nodeName.fontName = "HelveticaNeue-Bold"
        nodeName.fontSize = 60
        nodeName.fontColor = .white
        nodeName.position = CGPoint(x: 0, y: -15)
        nodeName.zPosition = 10
        nodeName.horizontalAlignmentMode = .center
        creationNode.name = "creationNode"
        creationNode.addChild(nodeName)
        
        addChild(creationNode)
    }
    
    func spawnAsRootNode(node: StoryNode){
        if node.stringUUID != visitedNodes.last {
            visitedNodes.append(node.stringUUID!)
        } //We add the node to the visited list
        let rootNode = SKSpriteNode(imageNamed: mainNodeColor)
        rootNode.position = CGPoint(x: size.width/2, y: size.height/2)
        rootNode.size = CGSize(width: 200, height: 200)
        rootNode.name = node.stringUUID //Root node has it's uuid
        
        let nodeName = SKLabelNode(text: node.chapter?.chapterTitle ?? " ")
        nodeName.fontName = "HelveticaNeue-Thin"
        nodeName.fontSize = 25
        nodeName.fontColor = .black
        nodeName.zPosition = 10
        nodeName.horizontalAlignmentMode = .center
        rootNode.addChild(nodeName)
        
        let editNode = SKSpriteNode(imageNamed: editImage)
        editNode.position = CGPoint(x: 65, y: -65)
        editNode.zPosition = 20
        editNode.size = CGSize(width: 50, height: 50)
        editNode.name = "editionNode"
        rootNode.addChild(editNode)
        
        actualNode = rootNode

        nodesOnDisplay.append(actualNode!)
        nodesOnDisplay.append(nodeName)
        addChild(rootNode)
        
        //Spawn every children this node has around it.
        spawnChildrenAround(node: node)
    }
    
    //The story node that is marked down here is actually our last main focused node.
    func drawChild(radius: Double, nodeCount: Int, nodeToDraw: StoryNode){
        let degrees = 360/nodeCount
        let childNode = SKSpriteNode(imageNamed: childNodeColor)
        let x = radius * cos(Double(childDrawn * degrees))
        let y = radius * sin(Double(childDrawn * degrees))
        childNode.position = CGPoint(x: x, y: y)
        childNode.size = CGSize(width: 150, height: 150)
        childNode.name = nodeToDraw.stringUUID //Cada nodo hijo dibujado tiene su UUID como nombre
        
        let nodeName = SKLabelNode(text: nodeToDraw.chapter?.chapterTitle ?? " ")
        nodeName.fontName = "HelveticaNeue-Thin"
        nodeName.fontSize = 20
        nodeName.fontColor = .black
        nodeName.zPosition = 10
        nodeName.horizontalAlignmentMode = .center
        childNode.addChild(nodeName)
        
        nodesOnDisplay.append(childNode)
        nodesOnDisplay.append(nodeName)
        actualNode?.addChild(childNode)
    }
    
    func spawnChildrenAround(node: StoryNode){
        do {
            let numberOfChildren = node.childrenNodesUUID.count
            let realm = try Realm()
            for childId in node.childrenNodesUUID{
                let childNode =  realm.objects(StoryNode.self).filter(NSPredicate(format: "stringUUID CONTAINS %@", childId)).first
                actualChildren.append(childNode!.stringUUID!)
                drawChild(radius: 250, nodeCount: numberOfChildren, nodeToDraw: childNode!)
                childDrawn += 1
            }
        } catch {
            print("Unable to locate node's children.")
        }
        childDrawn = 0
    }
    
    func clearScreen(){
        for node in nodesOnDisplay {
            node.removeFromParent()
        }
    }
    
    func addEmitter(){
        let emitter = SKEmitterNode(fileNamed: "particles")
        emitter?.position = CGPoint(x: size.width/2, y: size.height/2)
        emitter?.particlePositionRange = CGVector(dx: 2650, dy: 2000)
        emitter?.particleBirthRate = CGFloat(integerLiteral: 5)
        addChild(emitter!)
    }
    
    func navigate(to newRootName: String){
        let newRoot = realm.objects(StoryNode.self).filter(NSPredicate(format: "stringUUID CONTAINS %@", newRootName)).first //Query to get story based on the id
        clearScreen()
        actualChildren = []
        spawnAsRootNode(node: newRoot!)
    }
    
    // MARK: - Interaction Functions
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let position = touches.first?.location(in: self) else { return }
        guard let tappedNode = nodes(at: position).first(where: { $0 is SKSpriteNode}) else { return }
        
        if actualChildren.contains(tappedNode.name ?? "ño"){
            navigate(to: tappedNode.name!)
        }
        
        switch tappedNode.name {
        case "returnNode":
            if visitedNodes.count == 1 {
                break
            } else {
                self.visitedNodes.removeLast()
                print("visited nodes: \(visitedNodes)")
                navigate(to: visitedNodes.last!)
            }
        case "creationNode":
            gameVCReference?.injectedParentNode = visitedNodes.last
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "segueToCreation"), object: nil)
            
        case "editionNode":
            let actualNodeID = visitedNodes.last
            let actualStoryNode = realm.objects(StoryNode.self).filter(NSPredicate(format: "stringUUID CONTAINS %@", actualNodeID!)).first //Query to get story based on the id
            let actualChapter = actualStoryNode?.chapter!
            gameVCReference?.injectedChapter = actualChapter?.chapterUUID
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "segueToEdition"), object: nil)
            
        default:
            print("\n")
        }
    }
    
}
