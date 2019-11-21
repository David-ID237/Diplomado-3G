//
//  GameManager+Core.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 8/1/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
class Operations{
    
    static let shared = Operations()
    
    var operations = ["+"]
    
    func NumberGame(level : Int) -> Number {
        var val = 1
        if level == 0 {
            val = Int.random(in: 1..<3)
        }else if level == 1{
            val = Int.random(in: 1..<5)
        }else if level == 2{
            val = Int.random(in: 1..<6)
        }else if level == 3{
            val = Int.random(in: 1..<7)
        }else if level == 4{
            val = Int.random(in: 1..<8)
        }else if level == 5{
            val = Int.random(in: 1..<9)
        }
        return Number(value: val)
    }
    
    func generateOperationLevel(level : Int, index : Int, location : Int) -> Level? {
        let num1 = NumberGame(level: level)
        var num2 = NumberGame(level: level)
        guard let operador = getOperator(level: level) else {return nil}
        while num2.value > num1.value && "-" == operador.raw {
            num2 = NumberGame(level: level)
        }
        var answer = 0
        if "p" == operador.raw{
            answer = num1.value + num2.value
        } else if "m" == operador.raw{
            answer = num1.value - num2.value
        }
        var result = Number(value: answer)
        
        if level < 5{
            result = getQuestion(number: result)
        }
        return Level(index : index, numero1: num1,
                     operador: operador, numero2: num2,
                     equals: getEquals(),
                     result: result, location: location)
    }
    
    func getOperator(level : Int)->Number?{
        if level > 3{
            operations.append("-")
        }
        guard let operatorRandom = operations.shuffled().first else {return nil}
        var operatorName = ""
        if operatorRandom == "-"{
            operatorName = "m"
        } else if operatorRandom == "+"{
            operatorName = "p"
        }
        return Number(value: -9, name: "\(Constant.assetsNumber)\(operatorName)", raw: operatorName)
    }
    
    func getEquals() ->Number{
        return Number(value: -8, name: "\(Constant.assetsNumber)e", raw: "e")
    }
    
    func getQuestion(number : Number) -> Number{
        return Number(value: number.value, name: "\(Constant.assetsNumber)q", raw: number.raw)
    }
    
    func generateMisille(_ level : Int, _ targets : [Int : Level] ) ->(Number, Number){
        var answerNoAleatory : Number?
        for (_ , value) in targets{
            answerNoAleatory = value.result
            break
        }
        let aleatory = NumberGame(level: level + 1)
        if let answer = answerNoAleatory{
            return (aleatory, answer)
        }
        return (NumberGame(level: level + 1), NumberGame(level: level + 1))
    }
    
    func getText(target : Level) -> String{
        return "\(target.numero1.raw) \(target.operador.raw) \(target.numero2.raw) \(target.equals.raw) \(target.result.raw)"
    }
}
