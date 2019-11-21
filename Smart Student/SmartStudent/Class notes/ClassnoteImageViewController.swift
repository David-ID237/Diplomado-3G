//
//  ClassnoteImageViewController.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 8/12/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import UIKit

class ClassnoteImageViewController: UIViewController {
    
    @IBOutlet weak var classnoteImageView: UIImageView!
    var imageData = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        classnoteImageView.image = UIImage(data: Data(base64Encoded: imageData)!)
    }
    
}
