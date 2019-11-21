//
//  ViewController.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 7/5/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController {
    
    @IBOutlet weak var buttonPlayOrReplay: UIButton!
    @IBOutlet weak var imagePlayOrReplay: UIImageView!
    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var best: UILabel!
    @IBOutlet weak var number0: UIImageView!
    @IBOutlet weak var number1: UIImageView!
    @IBOutlet weak var number2: UIImageView!
    @IBOutlet weak var number3: UIImageView!
    @IBOutlet weak var number4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: Constant.keyPlay) == false{
            self.imageTitle.isHidden = false
            self.score.isHidden = true
            self.best.isHidden = true
            
            self.imagePlayOrReplay.image = UIImage(named: "tap")
            self.buttonPlayOrReplay.setImage(UIImage(named: "btn_play"), for: .normal)
            
        }else{//Si ya se jugo mostrara el retry
            self.imageTitle.isHidden = true
            self.score.isHidden = false
            self.best.isHidden = false
            
            self.imagePlayOrReplay.image = UIImage(named: "retry")
            self.buttonPlayOrReplay.setImage(UIImage(named: "btn_reload"), for: .normal)
            let (bestScore, lastScore) = self.getScore()
            self.score.text = lastScore
            self.best.text = bestScore
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        //play background music
        
        Utils.moveIt(number0, CGFloat.Random(min: 2, max: 10), self.view.frame.width)
        Utils.moveIt(number1, CGFloat.Random(min: 2, max: 10), self.view.frame.width)
        Utils.moveIt(number2, CGFloat.Random(min: 2, max: 10), self.view.frame.width)
        Utils.moveIt(number3, CGFloat.Random(min: 2, max: 10), self.view.frame.width)
        Utils.moveIt(number4, CGFloat.Random(min: 2, max: 10), self.view.frame.width)
    }
    
    @IBAction func playGame(_ sender: UIButton) {
        sender.bounce {
            self.performSegue(withIdentifier: Constant.IdentifierToGame, sender: nil)
        }
    }
    
    func getScore() -> (String, String) {
        let defaults = UserDefaults.standard
        let score = defaults.integer(forKey: Constant.keyLastScore)
        let best = defaults.integer(forKey: Constant.keyHighScore)
        return (String(format:Constant.FORMAT_BESTSCORE, best), String(format: Constant.FORMAT_SCORE, score))
    }
    
}

