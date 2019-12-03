//
//  Modulo.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/15/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import Foundation

class Modulo {
    var moduleName : String
    var pregunta : [Pregunta]
    var score = 0
    
    init(moduleName: String, pregunta: [Pregunta]) {
        self.pregunta = pregunta
        self.moduleName = moduleName
    }
    
    init() {
        self.moduleName = String()
        self.pregunta = [Pregunta]()
    }
   
}

