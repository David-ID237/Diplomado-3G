//
//  VerificationPopUpViewController.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/24/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit

class VerificationPopUpViewController: UIViewController {

    @IBOutlet weak var verificationLabel: UILabel!
    @IBOutlet weak var rightAnswerLabel: UILabel!
    @IBOutlet weak var quizView: UIView!
    @IBOutlet weak var verificationImg: UIImageView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    var question : Pregunta?
    var selectedAnswer : Int?
    var isFinished : Bool?
    var totalOfQuestions : Int?
    var numberOfErrors : Int?
    var lqvc : LeccionesQuizVC?
    var comesFromLecciones = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Basic configuration for the views
        navigationController?.isNavigationBarHidden = true
        tabBarController?.navigationController?.isNavigationBarHidden = true
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
        setupPopUpViews()
    }
    
    //Called when user clicks the continue button, this method determines if the quiz is over
    @IBAction func dismiss(_ sender: Any) {
        if isFinished ?? true {
            performSegue(withIdentifier: "toPerformanceVC", sender: self)
        } else {
            self.dismiss(animated: true) {
                self.lqvc?.updateQuiz()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let performanceVC = segue.destination as! PerformanceViewController
        performanceVC.popUp = self
    }
}

extension VerificationPopUpViewController {
    //Sets the views for the popUpView, color, image and righttAnswer
    func setupPopUpViews(){
         rightAnswerLabel.text = question?.opciones[(question?.respuesta ?? 1) - 1]
        if selectedAnswer == question?.respuesta {
            verificationImg.image = UIImage(named: "check")
            background.backgroundColor = UIColor(red:0.75, green:0.95, blue:0.60, alpha:1.0)
            continueButton.backgroundColor = UIColor(red:0.48, green:0.78, blue:0.05, alpha:1.0)
            verificationLabel.textColor = UIColor(red:0.48, green:0.78, blue:0.05, alpha:1.0)
            rightAnswerLabel.textColor = UIColor(red:0.48, green:0.78, blue:0.05, alpha:1.0)
        }else{
            verificationImg.image = UIImage(named: "wrong")
            background.backgroundColor = UIColor(red:0.97, green:0.78, blue:0.79, alpha:1.0)
            continueButton.backgroundColor = UIColor(red:0.83, green:0.19, blue:0.19, alpha:1.0)
            verificationLabel.textColor = UIColor(red:0.83, green:0.19, blue:0.19, alpha:1.0)
            rightAnswerLabel.textColor = UIColor(red:0.83, green:0.19, blue:0.19, alpha:1.0)
        }
    }
}
