//
//  CellActionDelegate.swift
//  shopapp
//
//  Created by David on 8/5/19.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation
import UIKit

protocol CellActionDelegate: class {
    func deleteCell(cellId: Int)
    func presentView(view: UIViewController)
    func updateProduct(index: Int, product: Product)
}
