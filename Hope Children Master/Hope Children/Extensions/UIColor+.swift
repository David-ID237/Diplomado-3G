//
//  UIColor+.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/5/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    struct Flat {
        struct Green {
            static let Fern = UIColor(red:0.42, green:0.73, blue:0.45, alpha:1.0)
            static let MountainMeadow = UIColor(red:0.23, green:0.73, blue:0.62, alpha:1.0)
            static let ChateauGreen = UIColor(red:0.30, green:0.65, blue:0.39, alpha:1.0)
            static let PersianGreen = UIColor(red:0.17, green:0.65, blue:0.53, alpha:1.0)
        }
        
        struct Blue {
            static let PictonBlue = UIColor(red:0.36, green:0.68, blue:0.81, alpha:1.0)
            static let Mariner = UIColor(red:0.21, green:0.52, blue:0.77, alpha:1.0)
            static let CuriousBlue = UIColor(red:0.27, green:0.56, blue:0.71, alpha:1.0)
            static let Denim = UIColor(red:0.18, green:0.42, blue:0.68, alpha:1.0)
            static let Chambray = UIColor(red:0.28, green:0.34, blue:0.46, alpha:1.0)
            static let BlueWhale = UIColor(red:0.16, green:0.20, blue:0.30, alpha:1.0)
            static let Sky = UIColor(hex: 0x4ba3ff, alpha: 1)
        }
        
        struct Violet {
            static let Wisteria = UIColor(red:0.56, green:0.41, blue:0.71, alpha:1.0)
            static let BlueGem = UIColor(red:0.33, green:0.24, blue:0.50, alpha:1.0)
        }
        
        struct Yellow {
            static let Energy = UIColor(red:0.95, green:0.83, blue:0.44, alpha:1.0)
            static let Turbo = UIColor(red:0.97, green:0.76, blue:0.24, alpha:1.0)
        }
        
        struct Orange {
            static let NeonCarrot = UIColor(red:0.97, green:0.62, blue:0.24, alpha:1.0)
            static let Sun = UIColor(red:0.93, green:0.47, blue:0.25, alpha:1.0)
        }
        
        struct Red {
            static let TerraCotta = UIColor(red:0.90, green:0.42, blue:0.36, alpha:1.0)
            static let Valencia = UIColor(red:0.80, green:0.28, blue:0.27, alpha:1.0)
            static let Cinnabar = UIColor(red:0.86, green:0.31, blue:0.28, alpha:1.0)
            static let WellRead = UIColor(red:0.70, green:0.20, blue:0.20, alpha:1.0)
        }
        
        struct Gray {
            static let AlmondFrost = UIColor(red:0.64, green:0.56, blue:0.52, alpha:1.0)
            static let WhiteSmoke = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
            static let Iron = UIColor(red:0.82, green:0.84, blue:0.85, alpha:1.0)
            static let IronGray = UIColor(red:0.46, green:0.44, blue:0.42, alpha:1.0)
        }
    }
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public static func random() -> UIColor {
        let maxValue = UIColorList.count
        let rand = Int(arc4random_uniform(UInt32(maxValue)))
        return UIColorList[rand]
    }
    
    public static func randomGray() -> UIColor {
        let maxValue = UIColorListGray.count
        let rand = Int(arc4random_uniform(UInt32(maxValue)))
        return UIColorListGray[rand]
    }
  
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let trackStrokeColor = UIColor.rgb(r: 48, g: 66, b: 151)
    static let pulseFillColor = UIColor.rgb(r: 44, g: 93, b: 160)
    static let outlineStrokeColor = UIColor.rgb(r: 73, g: 160, b: 223)
    
    
}


let UIColorList:[UIColor] = [
    UIColor.black,
    UIColor.white,
    UIColor.Flat.Blue.BlueWhale,
    UIColor.Flat.Blue.Chambray,
    UIColor.Flat.Blue.CuriousBlue,
    UIColor.Flat.Blue.Denim,
    UIColor.Flat.Blue.Mariner,
    UIColor.Flat.Blue.PictonBlue,
    UIColor.Flat.Gray.AlmondFrost,
    UIColor.Flat.Gray.Iron,
    UIColor.Flat.Gray.IronGray,
    UIColor.Flat.Gray.WhiteSmoke,
    UIColor.Flat.Green.ChateauGreen,
    UIColor.Flat.Green.Fern,
    UIColor.Flat.Green.MountainMeadow,
    UIColor.Flat.Green.PersianGreen,
    UIColor.Flat.Orange.NeonCarrot,
    UIColor.Flat.Orange.Sun,
    UIColor.Flat.Red.Cinnabar,
    UIColor.Flat.Red.TerraCotta,
    UIColor.Flat.Red.Valencia,
    UIColor.Flat.Red.WellRead,
    UIColor.Flat.Violet.BlueGem,
    UIColor.Flat.Violet.Wisteria,
]



let UIColorListGray:[UIColor] = [
    UIColor.Flat.Gray.AlmondFrost,
    UIColor.Flat.Gray.Iron,
    UIColor.Flat.Gray.IronGray,
    UIColor.Flat.Gray.WhiteSmoke,
]

