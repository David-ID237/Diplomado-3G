//
//  UIImage+base64.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 8/11/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func encodedBase64() -> String? {
        guard let data = self.jpegData(compressionQuality: 0.95) else { return nil }
        return data.base64EncodedString()
    }
}
