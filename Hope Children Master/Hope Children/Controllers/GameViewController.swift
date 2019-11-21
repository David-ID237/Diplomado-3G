//
//  GameViewController.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/5/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import UIKit
import ARKit

class GameViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var shoot1: UIButton!
    @IBOutlet weak var shoot2: UIButton!
    
    var gameManager = GameManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupTime()
        self.loadingScene()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.sessionARPause()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    @objc func didGameOver(_ notification : NSNotification){
        self.gameOver()
    }

    @IBAction func shotAnswer(_ sender: UIButton) {
        self.generateMissile(sender.tag)
    }
    
    @IBAction func menuGame(_ sender: UIButton) {
        self.showDialog(.slideBottomTop)
    }
    
    func setupView(){
        gameManager.labelScore = score
        NotificationCenter.default.addObserver(self, selector: #selector(didGameOver(_:)), name: .GameOver, object: nil)
        if gameManager.state == .GameOver {
            self.gameOver()
            return
        }
        if gameManager.state == .ToPlay {
            gameManager.reset()
            gameManager.state = .Playing
            self.sessionInit()
            self.sessionARStart()
            self.createMissile()
            return
        }
    }
    
    func setupTime(){
        self.view.addSubview(gameManager.timer)
        gameManager.timer.anchor(top: self.view.layoutMarginsGuide.topAnchor, leading: self.view.layoutMarginsGuide.leadingAnchor, trailing: nil, bottom: nil, padding: UIEdgeInsets(top: 45, left:30, bottom: 10, right: 10), size: CGSize(width: 35, height: 35))
    }
    
    func loadingScene(){
        gameManager.timer.run()
    }
    
    func gameOver(){
        self.gameManager.saveState()
        self.gameManager.state = .ToPlay
        self.gameManager.timer.reset()
        self.sessionARClean()
        UserDefaults.standard.set(true, forKey: Constant.keyPlay)
        NotificationCenter.default.removeObserver(self, name: .GameOver, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlertOut() {
        let alert = UIAlertController(
            title: Constant.TEXT_SALIR,
            message: Constant.MESSAGE_SALIR,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constant.CANCEL, style: .default,
        handler: { _ in  self.playPause() }))
        alert.addAction(UIAlertAction(title: Constant.OUT, style: .default,            handler: {_ in self.gameOver()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func playPause(){
        if gameManager.timer.isPaused{
            gameManager.timer.play()
            Utils.isEnabled([shoot1, shoot2], isEnabled: true)
            shoot1.scaleButton(normal: true)
            shoot2.scaleButton(normal: true)
            self.sessionARResume()
        } else{
            gameManager.timer.pause()
            Utils.isEnabled([shoot1, shoot2], isEnabled: false)
            shoot1.scaleButton(normal: false)
            shoot2.scaleButton(normal: false)
            self.sessionARPause()
        }
    }
    
    func createMissile(){
        DispatchQueue.main.async {
            let (missile0, missile1) = self.gameManager.operations.generateMisille(self.gameManager.level, self.gameManager.operationTargets)
            
            self.shoot1.setTitle("", for: .normal)
            self.shoot2.setTitle("", for: .normal)

            self.shoot1.tag = missile0.value
            self.shoot1.setImage(UIImage(named: missile0.name), for: .normal)
            
            self.shoot2.tag = missile1.value
            self.shoot2.setImage(UIImage(named: "\(Constant.assetsNumber)\(missile1.raw)"), for: .normal)
            
            self.shoot1.scaleRevert()
            self.shoot2.scaleRevert()
        }
    }
    
    func showDialog(_ animationPattern: LSAnimationPattern) {
        let dialogViewController = UIMenu(nibName: "UIMenu", bundle: nil)
        dialogViewController.delegate = self
        presentDialogViewController(dialogViewController, animationPattern: animationPattern)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissDialog(_:)), name: .CloseMenu, object: nil)
        playPause()
    }
    
    @objc func dismissDialog(_ notification : NSNotification){
        dismissDialog()
    }
    
    func dismissDialog() {
        playPause()
        NotificationCenter.default.removeObserver(self, name: .CloseMenu, object: nil)
        dismissDialogViewController(LSAnimationPattern.fadeInOut)
    }
    
}



