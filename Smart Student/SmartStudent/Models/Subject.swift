 //
//  Subject.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 7/23/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import Foundation
import RealmSwift

class Weekday : Object{
    @objc dynamic var day : Int = Int()
}

class Subject : Object{
    @objc dynamic var name : String = String()
    @objc dynamic var classroom : String = String()
    @objc dynamic var teacher : String = String()
    @objc dynamic var startTime : Date = Date()
    @objc dynamic var endTime : Date = Date()
    let weekdays = List<Weekday>()
}



