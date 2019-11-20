//
//  LoginViewController.swift
//  EvaluateGM
//
//  Created by José Antonio Arellano Mendoza on 6/12/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rememberUserSwitch: UISwitch!
    
    //Properties
    var user: User?
    var createdUser: User?
    var createdPassword: String?
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        //Database connection
        ref = Database.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passwordTextField.text = ""
        //Remember email
        if let rememberedEmail = UserDefaults.standard.object(forKey: "usersEmail") {
            emailTextField.text = rememberedEmail as? String
            rememberUserSwitch.isOn = true
        } else {
            emailTextField.text = ""
            rememberUserSwitch.isOn = false
        }
        //Uncomment to keep session and not login every time app runs
        //keepOpennedSession()
    }
    
    //Unwind segues
    @IBAction func saveUser(unwindSegue: UIStoryboardSegue) {
        guard let addUserViewController = unwindSegue.source as? AddUserTableViewController else {
            print("Cant receive new user")
            return
        }
        createdUser = addUserViewController.user
        guard let newUser = createdUser else {
            return
        }
        //Create User
        Auth.auth().createUser(withEmail: newUser.email, password: newUser.password) { (user, error) in
            if user != nil {
                print("User created successfully")
                self.saveUserInDB()
            } else {
                if let error = error?.localizedDescription {
                    print("Firebase error: \(error)")
                } else {
                    print("Code error")
                }
            }
        }
    }
    @IBAction func cancelNewUser(unwindSegue: UIStoryboardSegue) {
    }
    
    //Actions
    @IBAction func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, emailTextField.text?.count != 0, passwordTextField.text?.count != 0 else {
            let alertController = UIAlertController(title: "Campos vacíos", message: "Ingrese email y contraseña.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        authenticateUser(email: email, pass: password)
    }
    func authenticateUser(email: String, pass: String) {
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if let user = user {
                //Successful login
                print("Successful login, user: \(user)")
                self.performSegue(withIdentifier: "toEmployeesTableVC", sender: nil)
                if self.rememberUserSwitch.isOn {
                    UserDefaults.standard.set(self.emailTextField.text, forKey: "usersEmail")
                } else {
                    UserDefaults.standard.removeObject(forKey: "usersEmail")
                }
            } else {
                //Failed login
                if let error = error?.localizedDescription {
                    print("Firebase error: \(error)")
                    let alertController = UIAlertController(title: "Datos inválidos", message: "Ingrese sus credenciales nuevamente.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    print("Code error")
                }
            }
        }
    }
    
    func saveUserInDB() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let email = Auth.auth().currentUser?.email else { return }
        guard let newUser = createdUser else { return }
        
        let fields: [String: Any] = ["name": newUser.name,
                                     "lastName": newUser.lastName,
                                     "email": email,
                                     "isSupervisor": newUser.isSupervisor,
                                     "password": newUser.password,
                                     "userId": userId]
        ref.child("users").child(userId).setValue(fields)
        let alertController = UIAlertController(title: "Nuevo usuario", message: "Nuevo usuario registrado exitosamente.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func keepOpennedSession() {
        Auth.auth().addStateDidChangeListener { (auth, error) in
            if error == nil {
                print("Not logged in")
            } else {
                print("Logged in")
                self.performSegue(withIdentifier: "toEmployeesTableVC", sender: nil)
            }
        }
    }
    
    func updateUI() {
        //Programmatic Constraints
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        loginButton.layer.cornerRadius = 5.0
        
        rememberUserSwitch.translatesAutoresizingMaskIntoConstraints = false
        rememberUserSwitch.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }

}
