//
//  InstitutionsService.swift
//  FesANews
//
//  Created by Alan Vargas on 5.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import Foundation
import CodableFirebase

class InstitutionsService: InstitutionsProtocol {
  
  var institutions: institutionsList?
  
  func getInstitutions() -> institutionsList {
    return institutions ?? []
  }
  
  func getInstitutions(success: @escaping (institutionsList) -> Void, failure: @escaping (String) -> Void) {
    Fire.shared.database.collection("institutions").addSnapshotListener { (query, error) in
      if let err = error { failure( err.localizedDescription ) }
        
      else {
        var institutionsListObj = institutionsList()
        if let institutions = query?.documents {
          if institutions.isEmpty { print("There's no Institutions") }
            
          else {
            for data in institutions {
              let myInstitution = try! FirebaseDecoder().decode( Institution.self,
                                                                 from: data.data() )
              institutionsListObj.append( myInstitution )
            }
          }
        }
        self.institutions = institutionsListObj
        success( institutionsListObj )
      }
      
    }
  }
  
}
