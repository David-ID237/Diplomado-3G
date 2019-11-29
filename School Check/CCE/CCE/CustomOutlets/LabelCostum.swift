//
//  ButtonCostum.swift
//  CatalogoApp
//
//  Created by Kaleido 08 on 03/06/19.
//  Copyright © 2019 Kaleido Comunicación Interactiva S.C. All rights reserved.
//


import UIKit


@IBDesignable class LabelCostum: UILabel {
    
    @IBInspectable var lblCornerRadius: CGFloat = 15
    @IBInspectable var lblColor = #colorLiteral(red: 0.01960784314, green: 0.5529411765, blue: 0.5450980392, alpha: 1)
    @IBInspectable var lblBorderColor = #colorLiteral(red: 0.01960784314, green: 0.4666666667, blue: 0.5450980392, alpha: 1)
    @IBInspectable var lblBorderWidth: CGFloat = 2
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    override func awakeFromNib() {
        super .awakeFromNib()
        setupLabel()
    }
    
    
    override func prepareForInterfaceBuilder() {
        setupLabel()
    }
    
    func setupLabel(){
        layer.masksToBounds = true
        layer.cornerRadius = lblCornerRadius
        layer.backgroundColor = lblColor.cgColor
        layer.borderColor = lblBorderColor.cgColor
        layer.borderWidth = lblBorderWidth
        

       
        
    }
    
    
}
