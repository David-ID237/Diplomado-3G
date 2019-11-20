//
//  Route.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/11/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import Foundation

class Route {
    
    var address:Location?
    var seats = 1
    var days:String?
    var price:Int?
    var employee:Employee?
    var enterprise:Enterprise?
    var UID:String?
    var departureTimeHour:Int?
    var departureTimeMinutes:Int?
    var poolers: [String:Any]?
 
    func getTodayDate(at: (hour: Int, minute: Int)) -> Date {
        var dateComponents = Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day], from: Date())
        dateComponents.hour = at.hour
        dateComponents.minute = at.minute
        return Calendar.autoupdatingCurrent.date(from: dateComponents)!
    }
    
}
