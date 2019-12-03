//
//  Unidades.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/15/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import Foundation
class Unidad {
    
    var unidadName : String
    var modulo : [Modulo]
    var score = 0
    
    init(unidadName: String, modulo: [Modulo]) {
        self.unidadName = unidadName
        self.modulo = modulo
    }
    
    init() {
        self.unidadName = String()
        self.modulo = [Modulo]()
    }

}


