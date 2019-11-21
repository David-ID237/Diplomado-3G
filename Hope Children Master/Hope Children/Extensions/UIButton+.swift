//
//  UIButton+.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/14/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//
import Foundation
import UIKit

extension UIButton{
    typealias successUI = () -> Void
    func bounce(success: @escaping successUI){
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self!.transform = .identity
            }, completion: { finished in
                success()
        })
    }
    
    func scaleButton(normal : Bool){
        if normal{
            UIView.animate(withDuration: 0.6) {
                self.transform = CGAffineTransform.identity
            }
        }else{
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            }
        }
    }
    
    func scaleRevert(){
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { (_) in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
    
    func changeState(named : String){
        let imagenPlayPause = UIImage(named: named)
        if let imagen = imagenPlayPause{
            self.setImage(imagen, for: .normal)
        }
    }
}
