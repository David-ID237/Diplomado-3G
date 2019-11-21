//
//  HOPE_ChildrenTests.swift
//  HOPE ChildrenTests
//
//  Created by Antonyo Chavez Saucedo on 8/7/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import XCTest
@testable import HOPE_Children

class HOPE_ChildrenTests: XCTestCase {

    private let operations = Operations.shared
    
    override func setUp() {
    }

    override func tearDown() {
    }

    func testOperations() {
        let level = 0
        let number = operations.NumberGame(level: level)
        if number.name.contains("Number_"){
            XCTAssert(true)
        }
    }
    
    func testOperationsLevel() {
        let level = 0
        let index = 0
        let location = 0
        guard let operation = operations.generateOperationLevel(level: level, index: index, location: location) else {
            XCTAssert(false)
            return
        }
        let number1 = operation.numero1.value
        let number2 = operation.numero2.value
        if operation.operador.raw == "p"{
            if (number1 + number2) == operation.result.value{
                XCTAssert(true)
            }
        } else if operation.operador.raw == "m"{
            if (number1 - number2) == operation.result.value{
                XCTAssert(true)
            }
        } else {
            XCTAssert(false)
        }
    }
    
    func testOperationsMisiles() {
        let level = 0
        let index = 0
        let location = 0
        guard let operation = operations.generateOperationLevel(level: level, index: index, location: location) else {
            XCTAssert(false)
            return
        }
        var operationTargets : [Int : Level] = [:]
        operationTargets[0] = operation
        let (_, _) = operations.generateMisille(level, operationTargets) 
        XCTAssert(true)
    }

    func testPerformanceExample() {
        self.measure {
        }
    }

}
