//
//  PerformanceViewController.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/25/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit

class PerformanceViewController: UIViewController {

    @IBOutlet weak var performanceLabel: UILabel!
    @IBOutlet weak var errorCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    let animationStartDate = Date()
    let animationDuration = 1.5
    lazy var score : Int = 0
    var popUp: VerificationPopUpViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Basic configuration for the views
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.navigationController?.isNavigationBarHidden = true
        score = calculateScore()
        scoreCountLabel.text = String(score)
        setErrorLabel()
        setPerformanceLabel()
        setScoreLabel()
        setStarsImages(for: score)
    }
    //Called when user clicks the continue button, this method sets the score for the lesson and persist it with UserDefaults
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if popUp!.comesFromLecciones {
            let unitsVC = segue.destination as! UnitsTableViewController
            unitsVC.materia?.unidad[unitsVC.selectedUnit].modulo[unitsVC.selectedLesson-1].score = score
            UserDefaults.standard.set(score, forKey: unitsVC.materia?.unidad[unitsVC.selectedUnit].modulo[unitsVC.selectedLesson-1].moduleName ?? "CouldntGetModule")
        }else{
            let unitsVC = segue.destination as! UnitsRepasaViewController
            unitsVC.materia?.unidad[unitsVC.selectedUnit].score = score
            UserDefaults.standard.set(score, forKey: unitsVC.materia?.unidad[unitsVC.selectedUnit].unidadName ?? "CouldntGetUnit")
        }
    }
    
    //Called when user clicks the coninue button, popView alpha to 0
    @IBAction func continueButton(_ sender: Any) {
        popUp?.view.alpha = 0
    }
}


extension PerformanceViewController {
   
    //This method calculates the score for the lesson according to totalOfQuestion and numberOfErrors
    private func calculateScore() -> Int {
        let calification = popUp!.totalOfQuestions! - popUp!.numberOfErrors!
        var score = 0
        if calification <= 0 {
            score = 100
        } else {
            score = (calification * 1000) / popUp!.totalOfQuestions!
        }
        return score
    }
    
    //This method set the errolLabel according to the numberOfErrors
    private func setErrorLabel(){
        if popUp?.numberOfErrors == 1{
            errorCountLabel.text = "Tuviste \(popUp?.numberOfErrors ?? 0) error"
        } else{
            errorCountLabel.text = "Tuviste \(popUp?.numberOfErrors ?? 0) errores"
        }
    }
    
    //Set the performanceLabel according to the score
    private func setPerformanceLabel(){
        if score >= 900 {
            performanceLabel.text = "¡Perfecto!"
        }else if score >= 700 {
            performanceLabel.text = "¡Bien!\n¿Puedes hacerlo mejor?"
        }else if score >= 400{
            performanceLabel.text = "¡Sé que puedes hacerlo mejor!"
        }else{
            performanceLabel.text = "No te rindas\nTodos fallamos alguna vez"
        }
    }
    
    //Sets the rating images according to the score
    private func setStarsImages(for score: Int) {
        if  score == 1000 {
            star1.image = UIImage(named: "yellowStar")
            star2.image = UIImage(named: "yellowStar")
            star3.image = UIImage(named: "yellowStar")
            star4.image = UIImage(named: "yellowStar")
            star5.image = UIImage(named: "yellowStar")
            return
        } else if score >= 800{
            star1.image = UIImage(named: "yellowStar")
            star2.image = UIImage(named: "yellowStar")
            star3.image = UIImage(named: "yellowStar")
            star4.image = UIImage(named: "yellowStar")
            star5.image = UIImage(named: "grayStar")
            return
        } else if score >= 600{
            star1.image = UIImage(named: "yellowStar")
            star2.image = UIImage(named: "yellowStar")
            star3.image = UIImage(named: "yellowStar")
            star4.image = UIImage(named: "grayStar")
            star5.image = UIImage(named: "grayStar")
            return
        } else if score >= 400{
            star1.image = UIImage(named: "yellowStar")
            star2.image = UIImage(named: "yellowStar")
            star3.image = UIImage(named: "grayStar")
            star4.image = UIImage(named: "grayStar")
            star5.image = UIImage(named: "grayStar")
            return
        } else if score >= 200{
            star1.image = UIImage(named: "star")
            star2.image = UIImage(named: "grayStar")
            star3.image = UIImage(named: "grayStar")
            star4.image = UIImage(named: "grayStar")
            star5.image = UIImage(named: "grayStar")
            return
        } else {
            star1.image = UIImage(named: "emptyStar")
            star2.image = UIImage(named: "emptyStar")
            star3.image = UIImage(named: "emptyStar")
            star4.image = UIImage(named: "emptyStar")
            star5.image = UIImage(named: "emptyStar")
            return
        }
    }
    
    //Sets the socreLabel
    private func setScoreLabel(){
        let displayLink = CADisplayLink(target: self, selector: #selector (handleUpdate))
        displayLink.add(to: .main, forMode: RunLoop.Mode.default)
    }

    //Performs the animation of the text in scoreLabel
    @objc func handleUpdate(){
        let now = Date()
        let endValue = score
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration{
            scoreCountLabel.text = "\(endValue)"
        }else{
            let percentage = elapsedTime / animationDuration
            let value = percentage * Double(endValue)
            scoreCountLabel.text = String(format: "%.0f", value)
        }
        
    }
}

