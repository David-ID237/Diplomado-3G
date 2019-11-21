//
//  Classnote.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 8/11/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import Foundation
import RealmSwift

class Classnote : Object{
    var subject : Subject = Subject()
    @objc dynamic var subjectName : String = String()
    @objc dynamic var time : Date = Date()
    @objc dynamic var imageData : String = String()
}
