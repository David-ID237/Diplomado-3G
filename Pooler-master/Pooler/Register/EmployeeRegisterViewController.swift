//
//  EmployeeRegisterViewController.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/5/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import UIKit
import Firebase

class EmployeeRegisterViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    var employee = Employee()
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var enterpriseTF: UITextField!
    @IBOutlet weak var enterpriseAddressTextView: UITextView!
    
    let ref = Database.database().reference (withPath: "users")
    let scanner = QRScanViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Registro"
        profileImg.setRoundedImage()
        profileImg.image = UIImage(named: "EmployeeProfile")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func selectProfileImageç(_ sender: Any) {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = UIImagePickerController.SourceType.camera
        self.present(imageController,animated: true,completion: nil)
    }
    
    @IBAction func scanQRCode(_ sender: Any) {
        if let scannerVC = self.storyboard?.instantiateViewController(withIdentifier: "scannerVC") as? QRScanViewController {
            self.navigationController?.show(scannerVC, sender:nil)
            scanner.qrSessionReader()
            scannerVC.delegate = self
        }
    }
    @IBAction func hideKeyBoard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func registerEmployee(_ sender: Any) {
        employee.email = emailTextField.text
        employee.pass = passTextField.text
        
        Auth.auth().createUser(withEmail: employee.email!, password: employee.pass!) { (result, error) in
            if let error = error {
                print("failed to sign user up with error : ",error.localizedDescription)
                return
            }
            guard let uid = result?.user.uid else {return}
            self.addEmployee(uid:uid)
        }
    }
    
    func addEmployee(uid:String)  {
        employee.name = nameTextField.text
        employee.email = emailTextField.text
        employee.phone = phoneTF.text
        employee.profileImage = profileImg.image?.resized(withPercentage: 0.2)?.encodeToBase64(format: .png)
        employee.UID = uid
        let employeeO: Dictionary<String,Any> = ["name":employee.name!,
                                                   "phone":employee.phone!,
                                                   "email":employee.email!,
                                                   "profileImage":employee.profileImage!,
                                                   "enterprise":employee.enterprise!,
                                                   "uid": employee.UID!,
                                                   "active":employee.active!,
                                                   "timestamp":[".sv": "timestamp"],
                                                   "type": employee.type!]
        self.ref.child(uid).setValue(employeeO) {[weak self](error, result) in
            if let error = error {
                print("Failed to store, with error : ",error.localizedDescription)
                return
            }
            let alertController = UIAlertController(title: "Registro exitoso", message: "Tu registro ha sido completado.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Iniciar sesión", style: .default, handler: {[weak self] (action) in
                    self?.navigationController!.popToRootViewController(animated: true)
            })
            alertController.addAction(defaultAction)
            self!.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImg.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension EmployeeRegisterViewController: getEnterpriseCodeDelegate{
    
    func getEnterprise(enterprise: Enterprise) {
        enterpriseTF.text = enterprise.location?.locationTitle
        enterpriseAddressTextView.text = enterprise.location?.locationSubtitle
        self.employee.enterprise = enterprise.UID
    }
    
}

