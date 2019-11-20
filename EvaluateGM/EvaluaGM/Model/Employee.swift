//
//  Employee.swift
//  EvaluateGM
//
//  Created by José Antonio Arellano Mendoza on 6/12/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import Foundation
import UIKit

struct Employee: Equatable, Comparable {
    
    //General properties
    var photo: UIImage = UIImage(named: "User")!
    var name: String
    var lastName: String
    var id: String = ""
    var photoURL: String = ""
    var type: Type
    var hasBeenEvaluated: Bool {
        if averageArray.count == 0 {
            return false
        } else {
            return true
        }
    }
    
    //General qualifications
    //Culture Attatchment Starts
    var cultureAttatchmentArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (cultureAttatchmentArray.reduce(0,+) / Float(cultureAttatchmentArray.count))) {
                    cultureAttatchmentIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (cultureAttatchmentArray.reduce(0,+) / Float(cultureAttatchmentArray.count))) {
                    cultureAttatchmentIndicator = true
                } else {
                    cultureAttatchmentIndicator = false
                }
            } else {
                cultureAttatchmentIndicator = true
            }
        }
    }
    var cultureAttatchmentIndicator: Bool = true
    //Culture Attatchment Ends
    //DPO Implementation Starts
    var dpoImplementationArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (dpoImplementationArray.reduce(0,+) / Float(dpoImplementationArray.count))) {
                    dpoImplementationIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (dpoImplementationArray.reduce(0,+) / Float(cultureAttatchmentArray.count))) {
                    dpoImplementationIndicator = true
                } else {
                    dpoImplementationIndicator = false
                }
            } else {
                dpoImplementationIndicator = true
            }
        }
    }
    var dpoImplementationIndicator: Bool = true
    //DPO Implementation Ends
    //Attitude Starts
    var attitudeArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (attitudeArray.reduce(0,+) / Float(attitudeArray.count))) {
                    attitudeIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (attitudeArray.reduce(0,+) / Float(attitudeArray.count))) {
                    attitudeIndicator = true
                } else {
                    attitudeIndicator = false
                }
            } else {
                attitudeIndicator = true
            }
        }
    }
    var attitudeIndicator: Bool = true
    //Attitude Ends
    //Training adaptation starts
    var trainingAdaptationArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (trainingAdaptationArray.reduce(0,+) / Float(trainingAdaptationArray.count))) {
                    trainingAdaptationIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (trainingAdaptationArray.reduce(0,+) / Float(trainingAdaptationArray.count))) {
                    trainingAdaptationIndicator = true
                } else {
                    trainingAdaptationIndicator = false
                }
            } else {
                trainingAdaptationIndicator = true
            }
        }
    }
    var trainingAdaptationIndicator: Bool = true
    //Training adaptation ends
    //Performance starts
    var performanceArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (performanceArray.reduce(0,+) / Float(performanceArray.count))) {
                    performanceIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (performanceArray.reduce(0,+) / Float(performanceArray.count))) {
                    performanceIndicator = true
                } else {
                    performanceIndicator = false
                }
            } else {
                performanceIndicator = true
            }
        }
    }
    var performanceIndicator: Bool = true
    //Performance ends
    //1st specific grade starts
    var firstSpecificGradeArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (firstSpecificGradeArray.reduce(0,+) / Float(firstSpecificGradeArray.count))) {
                    firstSpecificGradeIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (firstSpecificGradeArray.reduce(0,+) / Float(firstSpecificGradeArray.count))) {
                    firstSpecificGradeIndicator = true
                } else {
                    firstSpecificGradeIndicator = false
                }
            } else {
                firstSpecificGradeIndicator = true
            }
        }
    }
    var firstSpecificGradeIndicator: Bool = true
    //1st specific grade ends
    //2nd specific grade starts
    var secondSpecificGradeArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (secondSpecificGradeArray.reduce(0,+) / Float(secondSpecificGradeArray.count))) {
                    secondSpecificGradeIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (secondSpecificGradeArray.reduce(0,+) / Float(secondSpecificGradeArray.count))) {
                    secondSpecificGradeIndicator = true
                } else {
                    secondSpecificGradeIndicator = false
                }
            } else {
                secondSpecificGradeIndicator = true
            }
        }
    }
    var secondSpecificGradeIndicator: Bool = true
    //2nd specific grade ends
    //3rd specific grade starts
    var thirdSpecificGradeArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (thirdSpecificGradeArray.reduce(0,+) / Float(thirdSpecificGradeArray.count))) {
                    thirdSpecificGradeIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (thirdSpecificGradeArray.reduce(0,+) / Float(thirdSpecificGradeArray.count))) {
                    thirdSpecificGradeIndicator = true
                } else {
                    thirdSpecificGradeIndicator = false
                }
            } else {
                thirdSpecificGradeIndicator = true
            }
        }
    }
    var thirdSpecificGradeIndicator: Bool = true
    //3rd specific grade ends
    //4th specific grade starts
    var fourthSpecificGradeArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (fourthSpecificGradeArray.reduce(0,+) / Float(fourthSpecificGradeArray.count))) {
                    fourthSpecificGradeIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (fourthSpecificGradeArray.reduce(0,+) / Float(fourthSpecificGradeArray.count))) {
                    fourthSpecificGradeIndicator = true
                } else {
                    fourthSpecificGradeIndicator = false
                }
            } else {
                fourthSpecificGradeIndicator = true
            }
        }
    }
    var fourthSpecificGradeIndicator: Bool = true
    //4th specific grade ends
    //5th specific grade starts
    var fifthSpecificGradeArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (fifthSpecificGradeArray.reduce(0,+) / Float(fifthSpecificGradeArray.count))) {
                    fifthSpecificGradeIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (fifthSpecificGradeArray.reduce(0,+) / Float(fifthSpecificGradeArray.count))) {
                    fifthSpecificGradeIndicator = true
                } else {
                    fifthSpecificGradeIndicator = false
                }
            } else {
                fifthSpecificGradeIndicator = true
            }
        }
    }
    var fifthSpecificGradeIndicator: Bool = true
    //5th specific grade ends
    //6th specific grade starts
    var sixthSpecificGradeArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (sixthSpecificGradeArray.reduce(0,+) / Float(sixthSpecificGradeArray.count))) {
                    sixthSpecificGradeIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (sixthSpecificGradeArray.reduce(0,+) / Float(sixthSpecificGradeArray.count))) {
                    sixthSpecificGradeIndicator = true
                } else {
                    sixthSpecificGradeIndicator = false
                }
            } else {
                sixthSpecificGradeIndicator = true
            }
        }
    }
    var sixthSpecificGradeIndicator: Bool = true
    //6th specific grade ends
    //Average starts
    var averageArray: [Float] = [] {
        didSet {
            if oldValue.count > 0{
                if((oldValue.reduce(0,+) / Float(oldValue.count)) < (averageArray.reduce(0,+) / Float(averageArray.count))) {
                    averageIndicator = true
                } else if((oldValue.reduce(0,+) / Float(oldValue.count)) == (averageArray.reduce(0,+) / Float(averageArray.count))) {
                    averageIndicator = true
                } else {
                    averageIndicator = false
                }
            } else {
                averageIndicator = true
            }
        }
    }
    var averageIndicator: Bool = true
    //Average ends
    //Specific properties
    var typeString: String {
        switch type {
        case .forklift:
            return "Montacarga"
        case .delivery:
            return "Reparto"
        case .warehouseAssistant:
            return "Asistente de almacén"
        case .deliveryAssistant:
            return "Asistente de reparto"
        }
    }
    
    //Constructor
    init(name: String, lastName: String, type: Type) {
        self.name = name
        self.lastName = lastName
        self.type = type
    }
    
    //Methods
    static func ==(lhs: Employee, rhs: Employee) -> Bool {
        return lhs.name == rhs.name && lhs.lastName == rhs.lastName
    }
    
    static func < (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.name < rhs.name
    }
    
    func getGeneralAverage() -> Float {
        if averageArray.count == 0 {
            return 0.0
        } else {
            return averageArray.reduce(0, +) / Float(averageArray.count)
        }
    }
    
    func getCultureAttatchmentAverage() -> Float {
        if cultureAttatchmentArray.count == 0 {
            return 0.0
        } else {
            return cultureAttatchmentArray.reduce(0, +) / Float(cultureAttatchmentArray.count)
        }

    }
    
    func getDpoImplementationAverage() -> Float {
        if dpoImplementationArray.count == 0 {
            return 0.0
        } else {
            return dpoImplementationArray.reduce(0, +) / Float(dpoImplementationArray.count)
        }
        
    }
    
    func getAttitudeAverage() -> Float {
        if attitudeArray.count == 0 {
            return 0.0
        } else {
            return attitudeArray.reduce(0, +) / Float(attitudeArray.count)
        }
        
    }
    
    func getTrainingAdaptationAverage() -> Float {
        if trainingAdaptationArray.count == 0 {
            return 0.0
        } else {
            return trainingAdaptationArray.reduce(0, +) / Float(trainingAdaptationArray.count)
        }
        
    }
    
    func getPerformanceAverage() -> Float {
        if performanceArray.count == 0 {
            return 0.0
        } else {
            return performanceArray.reduce(0, +) / Float(performanceArray.count)
        }
        
    }
    
    func getFirstSpecificGradeAverage() -> Float {
        if firstSpecificGradeArray.count == 0 {
            return 0.0
        } else {
            return firstSpecificGradeArray.reduce(0, +) / Float(firstSpecificGradeArray.count)
        }
        
    }
    
    func getSecondSpecificGradeAverage() -> Float {
        if secondSpecificGradeArray.count == 0 {
            return 0.0
        } else {
            return secondSpecificGradeArray.reduce(0, +) / Float(secondSpecificGradeArray.count)
        }
        
    }
    
    func getThirdSpecificGradeAverage() -> Float {
        if thirdSpecificGradeArray.count == 0 {
            return 0.0
        } else {
            return thirdSpecificGradeArray.reduce(0, +) / Float(thirdSpecificGradeArray.count)
        }
        
    }
    
    func getFourthSpecificGradeAverage() -> Float {
        if fourthSpecificGradeArray.count == 0 {
            return 0.0
        } else {
            return fourthSpecificGradeArray.reduce(0, +) / Float(fourthSpecificGradeArray.count)
        }
        
    }
    
    func getFifthSpecificGradeAverage() -> Float {
        if fifthSpecificGradeArray.count == 0 {
            return 0.0
        } else {
            return fifthSpecificGradeArray.reduce(0, +) / Float(fifthSpecificGradeArray.count)
        }
        
    }
    
    func getSixthSpecificGradeAverage() -> Float {
        if sixthSpecificGradeArray.count == 0 {
            return 0.0
        } else {
            return sixthSpecificGradeArray.reduce(0, +) / Float(sixthSpecificGradeArray.count)
        }
        
    }
}

enum Type {
    case forklift
    case delivery
    case warehouseAssistant
    case deliveryAssistant
}
