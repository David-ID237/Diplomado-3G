//
//  InstitutionsModel.swift
//  FesANews
//
//  Created by Alan Vargas on 5.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import Foundation

typealias institutionsList = [Institution]

struct Institution: Codable {
  
  var name: String?
  //var id: String?
  var nickname: String?
  
}
