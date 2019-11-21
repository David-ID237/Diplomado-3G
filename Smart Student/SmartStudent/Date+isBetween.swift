//
//  Date+isBetween.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 8/11/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import Foundation

extension Date{
    func isBetween(startTime: Date, endTime: Date) -> Bool{
        return startTime.compare(self) == self.compare(endTime)
    }
}
