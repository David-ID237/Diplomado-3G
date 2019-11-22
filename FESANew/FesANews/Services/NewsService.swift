//
//  NewsService.swift
//  FesANews
//
//  Created by Alan Vargas on 1.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import Foundation
import CodableFirebase

class NewsService: TimelineProtocol {
  var news: newsList?
  var collectionName = "news"
  
  func getNewsListFromRam() -> [NewModel] {
    return news ?? []
  }
  
  func publishNew(institution: String, nickname: String, date: String, content: String,
                  success: @escaping () -> Void, failure: @escaping(String) -> Void) {
    
    let dataObj: [String:Any] = [
      "content" : content,
      "date" : date,
      "institutionName" : institution,
      "nickname" : nickname
    ]
    Fire.shared.database.collection(collectionName).addDocument(data: dataObj) { (error) in
      if let err = error {
        failure(err.localizedDescription)
      } else {
        success()
      }
    }
  }

  func getNews(success: @escaping ( newsList ) -> Void, failure: @escaping (String) -> Void) {
    Fire.shared.database.collection(collectionName).addSnapshotListener { (query, error) in
      if let err = error { failure( err.localizedDescription ) }
      
      else {
        var newsListObj = newsList()
        if let news = query?.documents {
          if news.isEmpty { print("There's no News") }
          
          else {
            for data in news {
              let myNew = try! FirebaseDecoder().decode( NewModel.self,
                                                         from: data.data() )
              newsListObj.append( myNew )
            }
          }
        }
        self.news = newsListObj
        success( newsListObj )
      }
    }
  }
  
}

