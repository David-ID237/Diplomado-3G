//
//  RepasaQuizViewController.swift
//  Prepaton
//
//  Created by Elektra Natchos on 8/6/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit

class RepasaQuizViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var optionAButton: UIButton!
    @IBOutlet weak var optionBButton: UIButton!
    @IBOutlet weak var optionCButton: UIButton!
    @IBOutlet weak var optionDButton: UIButton!
    @IBOutlet weak var questionTextView: UITextView!
    
    var questions : [Pregunta]?
    private lazy var currentRandomNumber : Int = 0
    private lazy var previousRandomNumber : Int = 0
    lazy var currentQ = Pregunta()
    private lazy var increment = Progress()
    lazy var selectedAnswer : Int = 0
    lazy var numberOfErrors : Int = 0
    lazy var totalOfQuestions : Int = 0
    lazy var isFinished = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.11, green: 0.69, blue: 0.96, alpha: 1.0)
        questionTextView.isEditable = false
        increment.totalUnitCount = Int64(questions?.count ?? 0)
        totalOfQuestions = questions?.count ?? 0
        configureButtons()
        questionTextView.backgroundColor = .clear
        updateQuiz()
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func answerSelected(_ sender: UIButton) {
        selectedAnswer = sender.tag
        if sender.tag == currentQ.respuesta {
            questions?.remove(at: currentRandomNumber)
            increment.completedUnitCount += 1
            let incrementFloat = Float (increment.fractionCompleted)
            progressView.setProgress(incrementFloat, animated: true)
        } else{
            numberOfErrors += 1
        }
        
        if questions?.isEmpty ?? false {
            isFinished = true
        }
        performSegue(withIdentifier: "toPopUp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let popUp = segue.destination as! VerificationPopUpViewController
        popUp.question = currentQ
        popUp.selectedAnswer = selectedAnswer
        popUp.totalOfQuestions = totalOfQuestions
        popUp.numberOfErrors = numberOfErrors
        popUp.isFinished = isFinished
        popUp.rqvc = self
    }
}

extension RepasaQuizViewController {
    func updateQuiz(){
        if (questions?.count ?? 0) > 1{
            while currentRandomNumber == previousRandomNumber {
                currentRandomNumber = Int.random(in: 0 ... (questions?.count ?? 1) - 1)
            }
        } else{
            currentRandomNumber = Int.random(in: 0 ... (questions?.count ?? 1) - 1)
        }
        previousRandomNumber = currentRandomNumber
        currentQ = questions?[currentRandomNumber] ?? Pregunta()
        questionTextView.text = currentQ.enunciado
        optionAButton.setTitle(currentQ.opciones[0], for: .normal)
        optionBButton.setTitle(currentQ.opciones[1], for: .normal)
        optionCButton.setTitle(currentQ.opciones[2], for: .normal)
        optionDButton.setTitle(currentQ.opciones[3], for: .normal)
    }
    
    private func configureButtons() {
        optionAButton.titleLabel?.numberOfLines = 0
        optionAButton.layer.cornerRadius = 15
        optionAButton.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        
        optionBButton.titleLabel?.numberOfLines = 0
        optionBButton.layer.cornerRadius = 15
        optionBButton.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        
        optionCButton.titleLabel?.numberOfLines = 0
        optionCButton.layer.cornerRadius = 15
        optionCButton.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        
        optionDButton.titleLabel?.numberOfLines = 0
        optionDButton.layer.cornerRadius = 15
        optionDButton.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
    }
}
