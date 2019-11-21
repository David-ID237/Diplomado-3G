//
//  UIMenu.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 8/4/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
import UIKit

class UIMenu : UIViewController {
    weak var delegate: GameViewController?
    
    @IBOutlet weak var ButtonMusic: UIButton!
    @IBOutlet weak var ButtonSound: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bounds.size.height = UIScreen.main.bounds.size.height / 1.4
        view.bounds.size.width = UIScreen.main.bounds.size.width / 1.4
        guard let delegate = delegate else {return}
        music(delegate)
        sound(delegate)
    }
    
    @IBAction func resumeButton(_ sender: AnyObject) {
        guard let delegate = delegate else {return}
        delegate.dismissDialog()
    }
    
    @IBAction func sonidoButton(_ sender: AnyObject) {
        guard let delegate = delegate else {return}
        delegate.gameManager.sound()
        sound(delegate)
    }
    
    @IBAction func musicaButton(_ sender: AnyObject) {
        guard let delegate = delegate else {return}
        delegate.gameManager.music()
        let rootNode = delegate.sceneView.scene.rootNode
        delegate.gameManager.removeBackgroundMusic(rootNode)
        delegate.gameManager.playBackgroundMusic(rootNode)
        music(delegate)
    }
    
    @IBAction func salirButton(_ sender: AnyObject) {
        guard let delegate = delegate else {return}
        delegate.showAlertOut()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func music(_ delegate : GameViewController){
        DispatchQueue.main.async {
            if delegate.gameManager.settingsMusic{
                self.ButtonMusic.setImage(UIImage(named: "menu_musica_off"), for: .normal)
            }else{
                self.ButtonMusic.setImage(UIImage(named: "menu_musica_on"), for: .normal)
            }
        }
    }
    
    func sound(_ delegate : GameViewController){
        DispatchQueue.main.async {
            if delegate.gameManager.settingsSounds{
                self.ButtonSound.setImage(UIImage(named: "sonido_off"), for: .normal)
            }else{
                self.ButtonSound.setImage(UIImage(named: "sonido_on"), for: .normal)
            }
        }
    }
}
