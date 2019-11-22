//
//  InstitutionsProtocol.swift
//  FesANews
//
//  Created by Alan Vargas on 5.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import Foundation

protocol InstitutionsProtocol {
  func getInstitutions( success: @escaping(_ institutions: institutionsList) -> Void,
                        failure: @escaping(_ alert: String) -> Void )
}
