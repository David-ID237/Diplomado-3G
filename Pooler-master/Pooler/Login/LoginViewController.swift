//
//  LoginViewController.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/5/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    static let identifier = "loginVC"
    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
    var ref = DatabaseReference()
    var employee:Employee?
    var enterprise:Enterprise?
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func login(_ sender: Any) {
        if (accountTextField.text == "") || (passTextField.text == "") {
            let alertController = UIAlertController(title: "Error", message: "Ingresa tu correo y/o contraseña", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }else{
            Auth.auth().signIn(withEmail: accountTextField.text!, password: passTextField.text!) {[weak self] (user, error) in
                if error != nil {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self?.present(alertController, animated: true, completion: nil)
                    print("Failed to sign in with error : ",error!.localizedDescription)
                    return
                }else{
                    var dictionary:[String:Any]?
                    var typeOfUser = 0
                    guard let UID = Auth.auth().currentUser?.uid else { return }
                    self!.setReference(reference: "users").child(UID).observeSingleEvent(of: .value, with: {[weak self] (snapshot) in
                        if snapshot.exists() {
                            dictionary = snapshot.value as? [String:Any]
                            typeOfUser = (dictionary!["type"] as? Int)!
                            self!.fillObject(dictionary: dictionary!,typeOfUser:typeOfUser)
                        }
                        }, withCancel: nil)
                    
                }
                
            }
        }
        

    }
    
    
      
    
    func fillObject(dictionary:[String:Any],typeOfUser:Int)  {
        if typeOfUser == 1{
            self.employee = Employee()
            self.employee?.name = dictionary["name"] as? String
            self.employee?.email = dictionary["email"] as? String
            self.employee?.phone = dictionary["phone"] as? String
            self.employee?.profileImage = dictionary["profileImage"] as? String
            self.employee?.active = dictionary["active"] as? Int
            self.employee?.enterprise = dictionary["enterprise"] as? String
            self.employee?.UID = dictionary["uid"] as? String
            if self.employee?.active == 1{
                if let employeeVC = self.storyboard?.instantiateViewController(withIdentifier: "employeeHomeVC" ) as? EmployeeHomeViewController {
                    employeeVC.employee = self.employee!
                    self.navigationController?.setViewControllers([employeeVC], animated: true)
                    //                            enterpriseVC.delegate = self
                }
            }else{
                let alertController = UIAlertController(title: "Mensaje", message: "Tu empresa aun no ha activado tu perfil, intentalo mas tarde", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
          
            
        }else if typeOfUser == 2 {
            self.enterprise = Enterprise()
            self.enterprise?.location = Location()
            self.enterprise?.name = dictionary["name"] as? String
            self.enterprise?.email = dictionary["email"] as? String
            self.enterprise?.phone = dictionary["phone"] as? String
            self.enterprise?.location?.locationTitle = dictionary["addressTitle"] as? String
            self.enterprise?.location?.locationSubtitle = dictionary["addressSubtitle"] as? String
            self.enterprise?.location?.longitude = dictionary["longitude"] as? String
            self.enterprise?.location?.latitude = dictionary["latitude"] as? String
            self.enterprise?.profileImage = dictionary["profileImage"] as? String
            self.enterprise?.active = dictionary["active"] as? Int
            self.enterprise?.UID = dictionary["uid"] as? String
            if let enterpriseVC = self.storyboard?.instantiateViewController(withIdentifier: "enterpriseHomeVC" ) as? EnterpriseHomeViewController {
                enterpriseVC.enterprise = self.enterprise!
                self.navigationController?.setViewControllers([enterpriseVC], animated: true)
            }
        }
        
    }
    
    
    func setReference(reference:String) ->  DatabaseReference {
        self.ref = Database.database().reference (withPath: reference)
        return ref
    }
    
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
