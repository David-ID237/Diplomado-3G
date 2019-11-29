//
//  GameViewController.swift
//  SpriteKitPlaygrounds
//
//  Created by Luis Mauricio Esparza Vazquez on 8/2/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import SpriteKit

class GameViewController: UIViewController {
    
    var selectedStoryId: String?

    // Both injected data are UUID's so I can delegate my work to the realm database
    var injectedChapter: String?
    var injectedParentNode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = NodeMapScene(size: CGSize(width: 2732, height: 2048))
        scene.scaleMode = .resizeFill
        scene.storyId = selectedStoryId
        scene.gameVCReference = self //Code injection
        
        let skview = self.view as! SKView
        skview.showsFPS = true
        skview.showsNodeCount = true
        skview.ignoresSiblingOrder = true
        skview.preferredFramesPerSecond = 60
        skview.presentScene(scene)
        
        //Observer to open this view controller
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.segueToEdition), name: NSNotification.Name(rawValue: "segueToEdition"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.segueToCreation), name: NSNotification.Name(rawValue: "segueToCreation"), object: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    //MARK: Helper Functions
    func returnToMainMenu(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let storyboard = appDelegate.window?.rootViewController?.storyboard else { return }
        if let vc = storyboard.instantiateInitialViewController() {
            print("Go to main menu")
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toChapterCreation":
            let editionView = segue.destination as? TextEditorViewController
            editionView?.parentNodeUUID = injectedParentNode!
            editionView?.editionBool = false
            
        case "toChapterEdition":
            let editionView = segue.destination as? TextEditorViewController
            editionView?.chapterUUID = injectedChapter!
            editionView?.editionBool = true
            
        default:
            print("Unable to segue to Text Editor View Controller")
        }
    }
    
    // MARK: - Obj-C Function
    
    @objc func segueToCreation(){
        performSegue(withIdentifier: "toChapterCreation", sender: self)
        self.view.removeFromSuperview()
        self.view = nil
    }
    
    @objc func segueToEdition(){
        performSegue(withIdentifier: "toChapterEdition", sender: self)
        self.view.removeFromSuperview()
        self.view = nil
    }
}
