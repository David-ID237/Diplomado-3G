//
//  WelcomeController.swift
//  FesANews
//
//  Created by Alan Vargas on 7.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {
  
  @IBOutlet weak var okButton: UIButton!
  
  let userDefaults = UserDefaults()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUi()
  }
  
  private func setupUi() {
    okButton.layer.borderColor = UIColor.AppColor.mainBlue.cgColor
    okButton.layer.borderWidth = 1
    okButton.layer.cornerRadius = 20.0
  }
  
  @IBAction func okButtonAction(_ sender: UIButton) {
    setUserDefault()
    dismiss(animated: true, completion: nil)
  }
  
  private func setUserDefault() {
    userDefaults.set("false", forKey: "showWelcome")
  }

}
