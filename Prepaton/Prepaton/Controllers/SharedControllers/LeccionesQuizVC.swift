//
//  LeccionesQuizVC.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/23/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit

class LeccionesQuizVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var optionAButton: UIButton!
    @IBOutlet weak var optionBButton: UIButton!
    @IBOutlet weak var optionCButton: UIButton!
    @IBOutlet weak var optionDButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    var questions : [Pregunta]?
    private lazy var currentRandomNumber : Int = 0
    private lazy var previousRandomNumber : Int = 0
    lazy var currentQ = Pregunta()
    private lazy var increment = Progress()
    lazy var selectedAnswer : Int = 0
    lazy var numberOfErrors : Int = 0
    lazy var totalOfQuestions : Int = 0
    lazy var isFinished = false
    var comesFromLecciones = false

    override func viewDidLoad() {
        super.viewDidLoad()
        //Basic configuration for the views
        setBackgroundColor()
        navigationController?.isNavigationBarHidden = true
        tabBarController?.navigationController?.isNavigationBarHidden = true
        questionTextView.isEditable = false
        questionTextView.backgroundColor = .clear
        increment.totalUnitCount = Int64(questions?.count ?? 0)
        totalOfQuestions = questions?.count ?? 0
        configureButtons()
        updateQuiz()
    }
    
    //Called when user clicks on exit button
    @IBAction func dismissQuiz(_ sender: Any) {
        let alert = UIAlertController(title: "¿Deseas salir?", message: "Se perderá tu progreso actual", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Seguir estudiando", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Salir", style: .destructive, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //Calles when user selects an answer, this method determines either if the answer is right or not
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
        popUp.lqvc = self
        popUp.comesFromLecciones = comesFromLecciones
    }
}

extension LeccionesQuizVC {
    
    //Configuration of the views in the controller according to the current question
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
    
    //Configure the colors for the buttons
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
    
    //Sets the background color for the view
    private func setBackgroundColor() {
        let colors = [UIColor(red: 0.48, green: 0.78, blue: 0.05, alpha: 1.0),
                      UIColor(red: 0.11, green: 0.69, blue: 0.96, alpha: 1.0),
                      UIColor(red: 0.52, green: 0.29, blue: 0.73, alpha: 1.0)]
        let random = Int.random(in: 0 ... colors.count - 1)
        view.backgroundColor = colors[random]
    }
}
