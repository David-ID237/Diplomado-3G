//
//  Semester.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 7/22/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import Foundation
import RealmSwift

class Semester : Object {
    @objc dynamic var title: String = ""
    @objc dynamic var beginDate : Date = Date()
    @objc dynamic var endDate : Date = Date()
    
}
