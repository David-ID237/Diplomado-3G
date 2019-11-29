//
//  File.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 8/4/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit
import RealmSwift

class Chapter: Object {
    
    @objc dynamic var chapterTitle: String?
    @objc dynamic var contentsOfChapter: String?
    @objc dynamic var chapterUUID: String? = UUID().uuidString

}


/*Chapter class is in charge of storing the information that each SpriteKitNode will store, that way, we create nodes with the content already inside them*/
