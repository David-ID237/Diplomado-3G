//
//  LauncheImgagePreload.swift
//  shopapp
//
//  Created by David on 8/11/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class LauncheImgagePreload: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        preloadAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
