//
//  Pregunta.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/15/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import Foundation
class Pregunta {
    
    var enunciado : String
    var opciones : [String]
    var respuesta : Int
    
    init(){
        self.enunciado = String()
        self.opciones = [String]()
        self.respuesta = Int()
    }
    
    init(enunciado: String, opciones: [String], respuesta: Int) {
        self.enunciado = enunciado
        self.opciones = opciones
        self.respuesta = respuesta
    }
}





