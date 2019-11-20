//
//  EmployeeTests.swift
//  EvaluateGMTests
//
//  Created by José Antonio Arellano Mendoza on 8/8/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import Foundation
import XCTest

@testable import EvaluateGM

class EmployeeTests: XCTestCase {
    func testhasBeenEvaluated() {
        //Initial value must be false
        let employee = Employee(name: "Antonio", lastName: "Arellano", type: .forklift)
        XCTAssertFalse(employee.hasBeenEvaluated)
    }
    func testGeneralAverage() {
        var employee = Employee(name: "Antonio", lastName: "Arellano", type: .forklift)
        let numbers: [Float] = [7,8,9,10,9]
        for number in numbers {
            employee.cultureAttatchmentArray.append(number)
            employee.dpoImplementationArray.append(number)
            employee.attitudeArray.append(number)
            employee.trainingAdaptationArray.append(number)
            employee.performanceArray.append(number)
            employee.firstSpecificGradeArray.append(number)
            employee.secondSpecificGradeArray.append(number)
            employee.thirdSpecificGradeArray.append(number)
            employee.fourthSpecificGradeArray.append(number)
            employee.fifthSpecificGradeArray.append(number)
            employee.averageArray.append(number)
        }
        let average = employee.getGeneralAverage()
        XCTAssertTrue((numbers.reduce(0,+) / Float(numbers.count)) == average)
    }
}
