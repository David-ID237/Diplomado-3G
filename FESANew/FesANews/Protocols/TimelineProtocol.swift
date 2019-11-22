//
//  TimelineProtocol.swift
//  FesANews
//
//  Created by Alan Vargas on 1.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import Foundation

protocol TimelineProtocol {
  func getNews( success: @escaping(_ newsList: newsList) -> Void,
                failure: @escaping(_ alert: String) -> Void )
  
  func publishNew(institution: String,
                  nickname: String,
                  date: String,
                  content: String,
                  success: @escaping() -> Void,
                  failure: @escaping(String) -> Void)
  
}
