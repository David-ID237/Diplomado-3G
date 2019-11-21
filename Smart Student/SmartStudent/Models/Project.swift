//
//  Project.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 8/10/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import Foundation
import RealmSwift

class Project : Object{
    @objc dynamic var subjectName: String = String()
    @objc dynamic var title : String = String()
    @objc dynamic var deadline : Date = Date()
    //@objc dynamic var score : Double = 0.0
}
