//
//  ViewController.swift
//  CCE
//
//  Created by Carlos Ramirez on 12/6/18.
//  Copyright © 2018 Carlos Ramirez. All rights reserved.
//

import UIKit
import Firebase

class LogginCCE: UIViewController{
    
    @IBOutlet weak var txtFieldUser: UITextField!
    @IBOutlet weak var txtFieldPass: UITextField!
    @IBOutlet weak var lblSchoolCheck: UILabel!
    @IBOutlet weak var imageViewLogo: ImageViewCostum!
    
    var db: Firestore!
    var myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        setupUI()
        setupFirebase()
        
        
    }
    
    @IBAction func btnLoggin(_ sender: Any) {
        
        if txtFieldPass.text != "" && txtFieldUser.text != ""{
            self.showProgressView(myView: myView, message: Message.loading)
            access()
            
        } else {
            
            alert(title: Title.titleUps, message: Message.emptyFields )
            
        }
        
        
    }
    
    
    func access() {
        
        let user = txtFieldUser.text
        let pass = txtFieldPass.text
        
        
        let docRef = db.collection(FirebaseCollection.userAccess).document("Credentials")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                let dictionary = document.data()! as NSDictionary
                let keys = dictionary.allKeys
                let countKeysArray = keys.count
                var cont = 0
                repeat{
                    let dictKey: String = keys[cont] as! String
                    
                    if dictKey == user {
                        if let userCredentials = dictionary[dictKey] as? NSDictionary{
                            
                            if let passwrd = userCredentials["pass"] as? String{
                                
                                if passwrd == pass{
                                    
                                    self.goToHome()
                                    UserDefaults.standard.set(true, forKey: "isLogged")
                                    
                                } else {
                                    
                                    self.alert(title: Title.titleUps, message: Message.wrongFields)
                                }
                            }else{return}
                        } else {return}
                    }
                    cont = cont + 1
                }while (cont < countKeysArray)
                
                self.alert(title: Title.titleUps, message: Message.wrongFields)
                self.dismissProgressView(myView: self.myView)
                
            } else {
                
                self.alert(title: Title.titleUps, message: Message.wrongFields)
                self.dismissProgressView(myView: self.myView)
                
            }
        }
    }
    
    func goToHome(){
        self.dismissProgressView(myView: self.myView)
        performSegue(withIdentifier: SegueIdentifiers.toNavigationController, sender: nil)
        
    }
    
}

extension LogginCCE {

    func setupUI() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (Timer) in
            UIView.animate(withDuration: 2.0) {
                self.lblSchoolCheck.alpha = 1
                self.imageViewLogo.alpha = 1
            }
        }
    }
    
    func setupFirebase() {
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
    }
}


