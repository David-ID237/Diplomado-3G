//
//  SmartStudentTests.swift
//  SmartStudentTests
//
//  Created by Jesús Germán Ortiz Barajas on 8/12/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import XCTest
@testable import SmartStudent
class SmartStudentTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceGetSpecificDaySubjects() {
        let calendarViewController = CalendarViewController()
        self.measure {
            // Testing how much time get the selected day's subjects on CalendarView when one day is selected.
            let subjecst = calendarViewController.getSpecificDaySubjects(day: 2)
            
        }
    }

}
