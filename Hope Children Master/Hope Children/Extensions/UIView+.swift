//
//  UIView+.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/5/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func anchor(top : NSLayoutYAxisAnchor?,
                leading : NSLayoutXAxisAnchor?,
                trailing : NSLayoutXAxisAnchor?,
                bottom : NSLayoutYAxisAnchor?,
                padding : UIEdgeInsets = .zero,
                size : CGSize = .zero){
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top{
            topAnchor.constraint(equalTo : top, constant: padding.top).isActive = true
        }
        if let leading = leading{
            leadingAnchor.constraint(equalTo : leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo : trailing, constant: -padding.right).isActive = true
        }
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo : bottom, constant: -padding.bottom).isActive = true
        }
        if size.width > 0{
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height > 0{
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    func dimensionAnchors(height : NSLayoutDimension?, heightMultiplier : CGFloat = 1, width : NSLayoutDimension?, widthMultiplier : CGFloat = 1){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let height = height{
            self.heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier).isActive = true
        }
        
        if let width = width{
            self.widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier).isActive = true
        }
        
    }
    
    func centerAnchor(centerX : NSLayoutXAxisAnchor?,
                      centerY : NSLayoutYAxisAnchor?){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX{
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY{
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    
    func addBlurBackground() {
        self.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: self.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: self.widthAnchor),
            ])
        
    }
    
    
    
    
}
