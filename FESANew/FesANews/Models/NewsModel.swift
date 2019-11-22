//
//  NewsModel.swift
//  FesANews
//
//  Created by Alan Vargas on 2.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import Foundation

typealias newsList = [NewModel]

struct NewModel: Codable {
  
  var content: String?
  var date: String?
  var institutionName: String?
  var nickname: String?
  //var relevance: Int?
  
}
