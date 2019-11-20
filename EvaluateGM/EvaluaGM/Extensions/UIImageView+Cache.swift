//
//  UIImageView+Cache.swift
//  Evalúa GM
//
//  Created by José Antonio Arellano Mendoza on 7/29/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: URL) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if error != nil {
                guard let error = error else {
                    return
                }
                print(error)
                return
            }
            DispatchQueue.main.async {
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                        self.image = downloadedImage
                    }
                } else {
                    self.image = UIImage(named: "User")
                }
            }
        }
        task.resume()
    }
}
