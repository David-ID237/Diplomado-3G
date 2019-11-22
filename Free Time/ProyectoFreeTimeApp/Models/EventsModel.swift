//
//  EventsModel.swift
//  ProyectoFreeTimeApp
//
//  Created by Rodrigo Vivas y Noemí Rodríguez on 7/25/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation
import RealmSwift

public class LocalDatabaseManager{
    static var realm: Realm? {
        get{
            do{
                let realm = try Realm()
                return realm
            } catch{
                return nil
            }
        }
    }
}

class Task: Object {
    @objc dynamic var id = 0
    
    override static func primaryKey() -> String{
        return "id"
    }
    
    @objc dynamic var name = ""
    @objc dynamic var beginDate = ""
    @objc dynamic var endDate = ""
    @objc dynamic var beginHour = ""
    @objc dynamic var endHour = ""
    @objc dynamic var imageName = ""
    @objc dynamic var latitud = 0.0
    @objc dynamic var longitud = 0.0
    @objc dynamic var category = ""
    @objc dynamic var price = 0.0
    @objc dynamic var address = ""
    @objc dynamic var place = ""
    
}

struct EventsModel {
    var name: String
    var beginDate: String
    var endDate: String
    var beginHour: String
    var endHour: String
    var imageName: String
    var latitud: Double
    var longitud: Double
    var category: String
    var price: Double
    var address: String
    var place: String
}
