//
//  AddUserTableViewController.swift
//  EvaluateGM
//
//  Created by José Antonio Arellano Mendoza on 7/7/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import UIKit

class AddUserTableViewController: UITableViewController {
    
    //Properties
    var user: User = User(name: "Name", lastName: "Last names", email: "email", password: "password", isSupervisor: true)
    var samePasswords: Bool = false
    
    //Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reafirmPasswordTextField: UITextField!
    @IBOutlet weak var supervisorSwitch: UISwitch!
    @IBOutlet weak var humanResourcesSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var passwordsIndicator: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let name = nameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        user.name = name
        user.lastName = lastName
        user.email = email
        user.password = password
        user.isSupervisor = supervisorSwitch.isOn
    }
    
    //Actions
    @IBAction func supervisorSwitchChange(_ sender: UISwitch) {
        if sender.isOn {
            humanResourcesSwitch.isOn = false
        } else {
            humanResourcesSwitch.isOn = true
        }
    }
    @IBAction func humanResourcesSwitchChange(_ sender: UISwitch) {
        if sender.isOn {
            supervisorSwitch.isOn = false
        } else {
            supervisorSwitch.isOn = true
        }
    }
    @IBAction func nameTextFieldChange(_ sender: UITextField) {
        if sender.text?.count != 0 && lastNameTextField.text?.count != 0 && emailTextField.text?.count != 0 && passwordTextField.text?.count != 0 && reafirmPasswordTextField.text?.count != 0 && samePasswords {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    @IBAction func lastNameTextFieldChange(_ sender: UITextField) {
        if sender.text?.count != 0 && nameTextField.text?.count != 0 && emailTextField.text?.count != 0 && passwordTextField.text?.count != 0 && reafirmPasswordTextField.text?.count != 0 && samePasswords {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    @IBAction func emailTextFieldChange(_ sender: UITextField) {
        if sender.text?.count != 0 && nameTextField.text?.count != 0 && lastNameTextField.text?.count != 0 && passwordTextField.text?.count != 0 && reafirmPasswordTextField.text?.count != 0 && samePasswords {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    @IBAction func passwordTextFieldChange(_ sender: UITextField) {
        if sender.text == reafirmPasswordTextField.text {
            samePasswords = true
            passwordsIndicator.text = "✓"
            passwordsIndicator.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
        } else {
            samePasswords = false
            passwordsIndicator.text = "✗"
            passwordsIndicator.textColor = .red
        }
        if sender.text?.count != 0 && nameTextField.text?.count != 0 && lastNameTextField.text?.count != 0 && emailTextField.text?.count != 0 && reafirmPasswordTextField.text?.count != 0 && samePasswords {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    @IBAction func reafirmPasswordTextFieldChange(_ sender: UITextField) {
        passwordsIndicator.isHidden = false
        if sender.text == passwordTextField.text {
            samePasswords = true
            passwordsIndicator.text = "✓"
            passwordsIndicator.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
        } else {
            samePasswords = false
            passwordsIndicator.text = "✗"
            passwordsIndicator.textColor = .red
        }
        if sender.text?.count != 0 && nameTextField.text?.count != 0 && lastNameTextField.text?.count != 0 && emailTextField.text?.count != 0 && passwordTextField.text?.count != 0 && samePasswords {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    @IBAction func checkReafirmedPassword(_ sender: UITextField) {
    }
    
    //Methods
    func setupUI() {
        tableView.allowsSelection = false
        saveButton.isEnabled = false
        supervisorSwitch.isOn = true
        humanResourcesSwitch.isOn = false
        passwordsIndicator.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        tableView.endEditing(true)
    }
}
