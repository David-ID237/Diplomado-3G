//
//  AddPaymentViewController.swift
//  CCE
//
//  Created by Carlos Ramirez on 8/4/19.
//  Copyright © 2019 Carlos Ramirez. All rights reserved.
//

import Firebase
import UIKit
import FirebaseStorage
import MessageUI

class AddPaymentViewController: UIViewController {
    
    
    @IBOutlet weak var txtFieldDate: UITextField!
    @IBOutlet weak var txtFieldClass: UITextField!
    @IBOutlet weak var txtFieldPersonWhoReceives: UITextField!
    @IBOutlet weak var txtFieldAmount: UITextField!
    
    var db: Firestore!
    var idStudent: String = "nil"
        var arrayDataPicker: [String] =  []
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFireBase()
        self.navigationItem.title = NavigationTitle.assignPay
        txtFieldDate.text = getCurrentDate()
        txtFieldAmount.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        setupPicker()
        
        
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        
        if let amountString = txtFieldAmount.text?.currencyInputFormatting() {
            txtFieldAmount.text = amountString
        }
    }
    
    
    @IBAction func AddNewPayAction(_ sender: Any) {
        if txtFieldAmount.text == nil ||
            txtFieldPersonWhoReceives.text == nil ||
            txtFieldClass.text == nil{
            
            alert(title: Title.titleUps, message: Message.emptyFields)
            
        }else{
        
            alertAreUSure(message: "Pago a Efectuar por el monto de \(txtFieldAmount.text ?? "0.0") ¿Desea continuar?")
        }
    }
    
    func getCurrentDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        return result
    }
    
    
    func addPayment(){
        
        let idPay = idStudent + "_" + randomString(length: 4)
        let curso = txtFieldClass.text
        let fecha = txtFieldDate.text
        let recibe = txtFieldPersonWhoReceives.text
        let monto = txtFieldAmount.text
        self.db.collection("students_data_payment_history").document(idStudent).updateData(
            
            [ idPay : [
                
                "Course": curso,
                "Date": fecha,
                "Received": recibe,
                "Amount": monto,
                "Details": "",
                "idPayment": idPay
                
                ]]
        ) { (err) in
            if let err = err {

                self.db.collection("students_data_payment_history").document("\(self.idStudent)").setData(
                    [ idPay : [
                        "Amount": monto,
                        "Date": fecha,
                        "Details": "",
                        "Received": recibe,
                        "Course": curso,
                        "idPayment": idPay
                        ]]
                ) { err in
                    if let err = err {
                    
                    } else {
                        
                        self.alertEmail(message: "Los datos capturados han sido guardados con éxito", title: "Datos Guardados", nombre: recibe!, curso: curso!, monto: monto!, fecha: fecha!)
                        
                    }
                }

            } else {
                
                self.alertEmail(message: "Los datos capturados han sido guardados con éxito", title: "Datos Guardados", nombre: recibe!, curso: curso!, monto: monto!, fecha: fecha!)
 
            }
        }
    }
    

    
}

extension AddPaymentViewController {

    func alertAreUSure(message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let alertActionOk = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            // func add payment to firebase
            self.addPayment()
        }
        alert.addAction(alertActionCancel)
        alert.addAction(alertActionOk)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alertEmail(message: String,title: String, nombre: String, curso: String, monto: String, fecha: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            self.sendEmail(nombre: nombre, curso: curso, monto: monto, fecha: fecha)
        }
        alert.addAction(alertActionOk)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}


extension AddPaymentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayDataPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayDataPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        txtFieldClass.text = arrayDataPicker[row]
    }
    
    @objc func donePicker() {
        
        txtFieldClass.resignFirstResponder()
        
    }
    
    func setupPicker(){
        
        arrayDataPicker.append("Ingreso a Bachillerato (COMIPEMS)")
        arrayDataPicker.append("Ingreso Secundaria")
        arrayDataPicker.append("Ingreso a Universidad (UNAM/IPN/UAM)")
        arrayDataPicker.append("Regularización")
        arrayDataPicker.append("Robótica")
        arrayDataPicker.append("Inglés 0")
        arrayDataPicker.append("Inglés 1")
        arrayDataPicker.append("Inglés 2")
        arrayDataPicker.append("Inglés 3")
        arrayDataPicker.append("Inglés 4")
        arrayDataPicker.append("Inglés 5")
        
        let picker: UIPickerView
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width ,height: 300))
        picker.backgroundColor = .white
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Aceptar", style: UIBarButtonItem.Style.plain, target: self, action: #selector (donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector (donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtFieldClass.inputView = picker
        txtFieldClass.inputAccessoryView = toolBar
        
        
    }
    
}

extension AddPaymentViewController: MFMailComposeViewControllerDelegate {
    
    func sendEmail(nombre: String, curso: String, monto: String, fecha: String){
        let mailComposeViewController = configureMailController(message: "CCE Centro de Capacitaciòn Escolar \n\n Historial de Pago \n\n Fecha: \(fecha) \n\n Curso: \(curso) \n\n Recibio: \(nombre) \n\n Monto: \(monto)\n\n\n")
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            //showMailError()
        }
    }
    
    func configureMailController(message: String) -> MFMailComposeViewController {
        
        let correoUsusario = email
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        //mailComposerVC.setToRecipients(["andrew@seemuapps.com"]) //ccepagos@gmail.com
        mailComposerVC.setToRecipients(["ccepagos@gmail.com",correoUsusario!])
        mailComposerVC.setSubject("Historial de Pago CCE Centro de Capacitaciòn Escolar")
        
        
        
        mailComposerVC.setMessageBody("\(message)", isHTML: false)
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
extension AddPaymentViewController {
    
    func setupFireBase() {
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
    }
    
    
}
