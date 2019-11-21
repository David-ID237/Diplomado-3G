//
//  Utils.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/5/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
import UIKit

class Utils {
   
    //Deshabilita o habilita
    static func isEnabled(_ views : [UIControl], isEnabled : Bool){
        for view in views{
            view.isEnabled = isEnabled
        }
    }
    //Mover imagenes
    static func moveIt(_ imageView: UIImageView,_ speed:CGFloat, _ width : CGFloat) {
        let speeds = speed
        let imageSpeed = speeds / width
        let averageSpeed = (width - imageView.frame.origin.x) * imageSpeed
        UIView.animate(withDuration: TimeInterval(averageSpeed), delay: 0.0, options: .curveLinear, animations: {
            imageView.frame.origin.x = width
        }, completion: { (_) in
            imageView.frame.origin.x = -imageView.frame.size.width
            self.moveIt(imageView, speeds, width)
        })
    }
}

