//
//  ButtonCostum.swift
//  CCE
//
//  Created by Carlos Ramirez on 7/23/19.
//  Copyright © 2019 Carlos Ramirez. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ButtonCostum: UIButton {
    
    @IBInspectable var btnBorderColor: UIColor = UIColor(hexString:"#509AAF")
    @IBInspectable var btnCornerRadius: CGFloat = 15
    @IBInspectable var btnBorderWidth: CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    override func awakeFromNib() {
        super .awakeFromNib()
        setupButton()
    }
    
    
    override func prepareForInterfaceBuilder() {
        setupButton()
    }
    
    func setupButton(){
        layer.masksToBounds = true
        layer.cornerRadius = btnCornerRadius
        layer.borderWidth = btnBorderWidth
        layer.borderColor = btnBorderColor.cgColor
        applyGradient(colours: [UIColor(hexString: "#509AAF"), UIColor(hexString: "#7DD8C7")])
        
        
    }
    

    
}
