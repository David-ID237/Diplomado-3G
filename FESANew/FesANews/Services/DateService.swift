//
//  DateService.swift
//  FesANews
//
//  Created by Alan Vargas on 3.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import Foundation

class DateService {
  
  let dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
  let userDateFormat = "dd-MM-yyyy"
  
  func dateFormatterFromFirebase( date:String ) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    let userDateFormatter = DateFormatter()
    userDateFormatter.dateFormat = userDateFormat
    
    let auxDate = dateFormatter.date(from: date)!
    return userDateFormatter.string(from: auxDate)
  }
  
  func dateFormatterForFirebase( date: Date ) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: date)
  }
  
}
