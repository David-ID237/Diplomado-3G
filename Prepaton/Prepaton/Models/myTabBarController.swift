//
//  myTabBarController.swift
//  Prepaton
//
//  Created by Elektra Natchos on 8/8/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit

class myTabBarController: UITabBarController {

    var materia: Materia?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Basic configuration for the navigationController
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = materia?.materia
        navigationItem.titleView?.tintColor = .darkGray
    }

}
