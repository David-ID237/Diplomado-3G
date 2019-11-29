//
//  PaymentHistory.swift
//  CCE
//
//  Created by Carlos Ramirez on 7/27/19.
//  Copyright © 2019 Carlos Ramirez. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PaymentHistory: UIViewController{
    
    var db: Firestore!
    var pagos: [Pagos] = []
    var idStudent = ""
    var myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    var email: String?
    
    @IBOutlet weak var tableViewPay: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        tableViewPay.delegate = self
        tableViewPay.dataSource = self
        tableViewPay.tableFooterView = UIView()
        
        //MARK: Setup BarButtons
        let editPerfil = UIButton(type: .system)
        editPerfil.setImage(UIImage(named: "add")?.withRenderingMode(.alwaysOriginal), for: .normal)
        editPerfil.tintColor = .white
        editPerfil.frame = CGRect(x: 0, y: 0, width: 34 , height: 34)
        editPerfil.addTarget(self, action: #selector(addPay(_:)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: editPerfil)]
        self.navigationItem.title = NavigationTitle.paymentHistory
        getPays()
        showProgressView(myView: myView, message: Message.loading)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if pagos.count != 0{
            showProgressView(myView: myView, message: Message.loading)
            pagos = []
            getPays()
            self.tableViewPay.isUserInteractionEnabled = true
        }
    }
    
    
    @IBAction func addPay(_ sender: Any){
        
        performSegue(withIdentifier: SegueIdentifiers.toPay, sender: nil)
        
    }
    
    
    func getPays(){
        
        let docRef = db.collection(FirebaseCollection.studentsDataPaymentHistory).document("\(idStudent)")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                
                let dictionary = document.data()! as NSDictionary
                let keys = dictionary.allKeys
                
                let countKeysArray = keys.count
                if keys.count == 0{
                    self.pagos.append(Pagos.init(monto: "vacio", fecha: "", detalles: "", recibe: "", clase: "", idPago: ""))
                    self.tableViewPay.reloadData()
                    self.tableViewPay.isUserInteractionEnabled = false
                    
                    
                    self.dismissProgressView(myView: self.myView)
                    return
                }
                var cont = 0
                repeat{
                    let dictKey: String = keys[cont] as! String
                    
                    let dictInfo = dictionary["\(dictKey)"] as! NSDictionary
                    let amount = dictInfo["Amount"] as! String
                    let date = dictInfo["Date"] as! String
                    let details = dictInfo["Details"] as! String
                    let received = dictInfo["Received"] as! String
                    let course = dictInfo["Course"] as! String
                    let idPayment = dictInfo["idPayment"] as! String
                    self.pagos.append(Pagos.init(monto: amount, fecha: date, detalles: details, recibe: received, clase: course, idPago: idPayment))
                    cont = cont + 1
                }while (cont < countKeysArray)
                
                self.tableViewPay.reloadData()
                self.dismissProgressView(myView: self.myView)
                
            } else {
                
                self.pagos.append(Pagos.init(monto: "vacio", fecha: "", detalles: "", recibe: "", clase: "", idPago: ""))
                self.tableViewPay.reloadData()
                self.tableViewPay.isUserInteractionEnabled = false
        
                self.dismissProgressView(myView: self.myView)
                
            }
        }
    }
    
    
    
    func deletePays(index: Int){
        
        db.collection(FirebaseCollection.studentsDataPaymentHistory).document(idStudent).updateData([
            pagos[index].idPago: FieldValue.delete(),
            ]) { err in
                if let err = err {
                    print("Error updating document in students_data_payment_history: \(err)")
                } else {
                    print("Document successfully updated in students_data_payment_history")
                }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.toPay {
            let destinationVC = segue.destination as! AddPaymentViewController
            destinationVC.idStudent = idStudent
            destinationVC.email = email
        }
    }
    
    
}

extension PaymentHistory: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if pagos[indexPath.row].monto == "vacio"{
            let cell = tableViewPay.dequeueReusableCell(withIdentifier: "EmptyPayment") as! EmptyPaymentTableViewCell
            return cell
        }
        let cell = tableViewPay.dequeueReusableCell(withIdentifier: "tableViewPaymentCell") as! PaymentHistoryTableViewCell
        
        cell.lblAmount.text = pagos[indexPath.row].monto
        cell.lblClass.text = pagos[indexPath.row].clase
        cell.lblDate.text = pagos[indexPath.row].fecha
        cell.lblRecieved.text = pagos[indexPath.row].recibe
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height: CGFloat = 150
        
        return height
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.deletePays(index: indexPath.row)
            self.pagos.remove(at: indexPath.row)
            self.tableViewPay.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    
    
}


