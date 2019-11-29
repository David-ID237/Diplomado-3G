//
//  ImageViewCostum.swift
//  CCE
//
//  Created by Carlos Ramirez on 7/27/19.
//  Copyright © 2019 Carlos Ramirez. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ImageViewCostum: UIImageView {
    
    @IBInspectable var imageViewBorderWidth: CGFloat = 2
    @IBInspectable var imageViewBorderColor = #colorLiteral(red: 0.01960784314, green: 0.4666666667, blue: 0.5450980392, alpha: 1)
    @IBInspectable var imageViewCornerRadius: CGFloat = 75
    
    
    override func awakeFromNib() {
        super .awakeFromNib()
        setupImageView()
    }
    
    
    override func prepareForInterfaceBuilder() {
        setupImageView()
    }
    
    
    func setupImageView(){
        layer.masksToBounds = true
        layer.borderWidth = imageViewBorderWidth
        layer.borderColor = imageViewBorderColor.cgColor
        layer.cornerRadius = frame.size.width/2
        
    }
    
}
