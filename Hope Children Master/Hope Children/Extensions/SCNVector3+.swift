//
//  Vector3+Math.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/6/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
import ARKit

extension SCNVector3 {
    
    static func random(_ targets : [Int : Level]) -> (SCNVector3, Int) {
        let maxValue = SCNVector3List.count
        var rand = 0
        var find = false
        if targets.count == 0{
            rand = Int(arc4random_uniform(UInt32(maxValue)))
        } else {
            while !find {
                var exist = false
                rand = Int(arc4random_uniform(UInt32(maxValue)))
                for (_, value) in targets{
                    if value.location == rand{
                        exist = true
                        break
                    }
                }
                if !exist{
                    find = true
                }
            }
        }
        return (SCNVector3List[rand], rand)
    }
    
    static func substractAtInvert(substract1 : SCNVector3, substract2 : SCNVector3) -> SCNVector3 {
        var tosubstract1 = substract1
        var tosubstract2 = substract2
        if tosubstract1.x < 0{ tosubstract1.x *= -1 }
        if tosubstract1.y < 0{ tosubstract1.y *= -1 }
        if tosubstract1.z < 0{ tosubstract1.z *= -1 }
        if tosubstract2.x < 0{ tosubstract2.x *= -1 }
        if tosubstract2.y < 0{ tosubstract2.y *= -1 }
        if tosubstract2.z < 0{ tosubstract2.z *= -1 }
        return tosubstract1 - tosubstract2
    }
    
    mutating func invert() -> SCNVector3 {
        return self * -1
    }

}


// Operadores SCNVector

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

func -(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x - right.x, left.y - right.y, left.z - right.z)
}

func *(left: SCNVector3, right: Float) -> SCNVector3 {
    return SCNVector3Make(left.x * right, left.y * right, left.z * right)
}

func ==(left: SCNVector3, right: SCNVector3) -> Bool {
    return (left.x == right.x && left.y == right.y && left.z == right.z)
}

//Ubicacion de las positiones donde apareceran los Target
let SCNVector3List:[SCNVector3] = [
    SCNVector3( -0.7, -0.3, -2.5),//centro botom
    SCNVector3( -2.1, -0.3, -2.5),//izq botom
    SCNVector3( 1.4, -0.3, -2.5),//der botom
    SCNVector3( -0.7, 0.3, -2.5),//centro
    SCNVector3( -2.1, 0.3, -2.5),//izq
    SCNVector3( 1.4, 0.3, -2.5),//der
]
