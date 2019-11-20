//
//  EnterpriseRegisterViewController.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/5/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//


import UIKit
import MapKit
import Firebase

class EnterpriseRegisterViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
//    Outlets
    
    var enterprise = Enterprise()
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var selectImageBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    let ref = Database.database().reference (withPath: "users")

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Registro"
        profileImage.setRoundedImage()
        profileImage.image = UIImage(named: "CompanyProfile")
        enterprise.location = Location()
       
    }
    
    @IBAction func hideKeyBoard(_ sender: Any) {
          view.endEditing(true)
    }
    @IBAction func searchAddress(_ sender: Any) {
        
    }
    @IBAction func registerEnterprise(_ sender: Any) {

        enterprise.email = emailTextField.text
        enterprise.pass = passTextField.text
        
        Auth.auth().createUser(withEmail: enterprise.email!, password: enterprise.pass!) {[weak self] (result, error) in
            if let error = error {
                print("failed to sign user up with error : ",error.localizedDescription)
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self!.present(alertController, animated: true, completion: {
                    return
                })
                
            }
            guard let uid = result?.user.uid else {return}
            self!.addEnterprise(uid:uid)
        }
        
    }
    
    func addEnterprise(uid:String) {
        enterprise.name = nameTextField.text
        enterprise.phone = phoneTextField.text
        enterprise.profileImage = profileImage.image?.encodeToBase64(format: .jpeg(0.95))
        enterprise.UID = uid
        let enterpriseO: Dictionary<String,Any> = ["name":enterprise.name!,
                           "phone":enterprise.phone!,
                           "email":enterprise.email!,
                           "profileImage":enterprise.profileImage!,
                           "latitude": enterprise.location!.latitude!,
                           "longitude": enterprise.location!.longitude!,
                           "addressTitle": enterprise.location!.locationTitle!,
                           "addressSubtitle": enterprise.location!.locationSubtitle!,
                           "qr":"",
                           "uid":enterprise.UID!,
                           "active":enterprise.active!,
                           "timestamp":[".sv": "timestamp"],
                           "type":enterprise.type!]
        
        self.ref.child(uid).setValue(enterpriseO) {[weak self](error, result) in
            if let error = error {
                print("Failed to store, with error : ",error.localizedDescription)
                return
            }
            let alertController = UIAlertController(title: "Registro exitoso", message: "Tu registro ha sido completado.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Iniciar sesión", style: .default, handler: {[weak self] (action) in
                    self?.navigationController!.popToRootViewController(animated: true)
//                }
            })
            alertController.addAction(defaultAction)
            self!.present(alertController, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    
    @IBAction func selectProfileImage(_ sender: Any) {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imageController,animated: true,completion: nil)
    }
    
    
    @IBAction func findAddress(_ sender: Any) {
        if let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "mapVC") as? MapViewController {
            self.navigationController?.show(mapVC, sender:nil)
            mapVC.delegate = self
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func generateQR(uid:String)->UIImage {
        let identifier = uid //+ String(describing:NSDate().timeIntervalSince1970)
        let dataForQR = identifier.data(using: .ascii)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(dataForQR, forKey: "inputMessage")
        
        let ciImage = filter?.outputImage
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let transformImage  = ciImage!.transformed(by: transform)
        
        return UIImage(ciImage: transformImage)
    }
}
extension EnterpriseRegisterViewController: setAddressDelegate{
    
    func returnAddres(coordinate: CLLocationCoordinate2D,address:MKLocalSearchCompletion) {
        addressTextView.text = address.subtitle
        enterprise.location?.longitude = coordinate.longitude.description
        enterprise.location?.latitude = coordinate.latitude.description
        enterprise.location?.locationTitle = address.title
        enterprise.location?.locationSubtitle = address.subtitle
        
    }
}
