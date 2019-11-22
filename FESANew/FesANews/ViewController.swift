//
//  ViewController.swift
//  FesANews
//
//  Created by Alan Vargas on 31.07.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {
  
  @IBOutlet weak var animationView: AnimationView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startAnimation()
  }
  
  private func startAnimation() {
    animationView.animation = Animation.named("loader")
    animationView.loopMode = .playOnce
    animationView.contentMode = .scaleToFill
    animationView.play { (finished) in
      self.goToMainNavigationController()
    }
  }
  
  private func goToMainNavigationController() {
    let storyboard = UIStoryboard( name: "Main", bundle: nil )
    let vc = storyboard.instantiateViewController(withIdentifier: "TabBar")
    present(vc, animated: true, completion: nil)
  }
}

