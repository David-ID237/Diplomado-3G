//
//  FirebaseService.swift
//  FesANews
//
//  Created by Alan Vargas on 2.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Fire {
  static var shared = Fire()
  
  let database = Firestore.firestore()
}
