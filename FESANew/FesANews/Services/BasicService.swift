//
//  BasicService.swift
//  FesANews
//
//  Created by Alan Vargas on 7.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import Foundation

class BasicService {
  
  static let shared = BasicService()
  
  var newsService: NewsService?
  var institutionsService: InstitutionsService?
  var dateService: DateService?
  
  init() {
    instantiateServices()
  }
  
  private func instantiateServices() {
    newsService = NewsService()
    institutionsService = InstitutionsService()
    dateService = DateService()
  }
  
}
