//
//  LaunchScreenViewController.swift
//  CCE
//
//  Created by Carlos Ramirez on 8/6/19.
//  Copyright © 2019 Carlos Ramirez. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var viewLaunchScreen: UIView!
    @IBOutlet weak var logo: UIImageView!
    
    var cont = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLogo()
        animationImage()
        decidePath()
        
        
    }
    
    func decidePath(){
        _ = Timer.scheduledTimer(withTimeInterval: 6, repeats: false) { (Timer) in
            
            let isLogged = UserDefaults.standard.bool(forKey: "isLogged")
            
            if isLogged{
                
                self.goToNavigation()
                
            } else {
                
                self.goToLoggin()
                
            }
            
        }
    }
    
    func showLogo(){
        logo.alpha = 0
        
        UIView.animate(withDuration: 3) {
            self.logo.alpha = 1
        }
    }
    
    func animationImage(){
        
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { (Timer) in
            UIView.animate(withDuration: 1.0, animations: {() -> Void in
                self.logo?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }, completion: {(_ finished: Bool) -> Void in
                UIView.animate(withDuration: 1.0, animations: {() -> Void in
                    self.logo?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    
                })
            })
        }
    }
    
    func goToNavigation(){
        
        performSegue(withIdentifier: "segueToNavigation", sender: nil)
    }
    
    func goToLoggin(){
        
        performSegue(withIdentifier: "segueGoToLoggin", sender: nil)
        
    }
    
    
}
