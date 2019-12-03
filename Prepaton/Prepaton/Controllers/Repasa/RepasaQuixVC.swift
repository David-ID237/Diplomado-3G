//
//  RepasaQuixVC.swift
//  Prepaton
//
//  Created by Elektra Natchos on 8/6/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit

class RepasaQuizVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var optionAButton: UIButton!
    @IBOutlet weak var optionBButton: UIButton!
    @IBOutlet weak var optionCButton: UIButton!
    @IBOutlet weak var optionDButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    var questions : [Pregunta]?
    private lazy var currentRandomNumber : Int = 0
    private lazy var 

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}
