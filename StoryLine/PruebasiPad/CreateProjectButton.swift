//
//  CustomButton.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/28/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit

class CreateButton: UIButton{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    func setupButton(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle("Create", for: .normal)
        self.setTitleColor(.black, for: .normal)
    }
}
