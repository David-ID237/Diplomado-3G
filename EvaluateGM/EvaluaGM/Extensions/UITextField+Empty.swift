//
//  UITextField+Empty.swift
//  EvaluateGM
//
//  Created by José Antonio Arellano Mendoza on 6/14/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    var isEmpty: Bool {
        if let text = self.text, !text.isEmpty {
            return false
        }
        return true
    }
}
