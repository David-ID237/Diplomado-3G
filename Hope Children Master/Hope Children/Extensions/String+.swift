//
//  Strin+.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/31/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
extension String{
    func replace(of: String, with: String) -> String{
        return self.replacingOccurrences(of: of, with: with)
    }
    
    func replace(of: String) -> String{
        return self.replacingOccurrences(of: of, with: "")
    }
}
