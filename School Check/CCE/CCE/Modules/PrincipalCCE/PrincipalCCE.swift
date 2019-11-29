//
//  PrincipalCCE.swift
//  CCE
//
//  Created by Carlos Ramirez on 12/7/18.
//  Copyright © 2018 Carlos Ramirez. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class PrincipalCCE: UIViewController {
    
    var db: Firestore!
    var dataRowTable: [Alumnos] = []
    var studentToDetails: String = "nil"
    var idStudent: String = ""
    var studentsUid: [String] = []
    var subtitleDataRowTable: [String] = []
    var filterDataRowTable = [Alumnos]()
    
    var myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    var isSearching = false
    
    @IBOutlet weak var tableViewStudents: UITableView!
    @IBOutlet weak var btnAddStudent: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        setupFirebase()
        setupUI()
        getStudents()
        setupNavigationBar()
        showProgressView(myView: myView, message: Message.loading)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if dataRowTable.count != 0{
            showProgressView(myView: myView, message: Message.loading)
            studentsUid = []
            subtitleDataRowTable = []
            filterDataRowTable = []
            dataRowTable = []
            getStudents()
            self.searchBar.isUserInteractionEnabled = true
            self.tableViewStudents.isUserInteractionEnabled = true
        }
    }
    
    func getStudents(){
        db.collection(FirebaseCollection.studentData).getDocuments() { (querySnapshot, err) in
            if let err = err {
               
            } else {
                
                if let data = querySnapshot?.documents, data == [] {
                    
                    self.dataRowTable.append(Alumnos.init(nombre: "", escuela: "", tutor: "", curso: "", direccion: "", telefono: "", correo: "", ID: ""))
                    self.searchBar.isUserInteractionEnabled = false
                        self.tableViewStudents.isUserInteractionEnabled = false
                    self.tableViewStudents.reloadData()
                    self.dismissProgressView(myView: self.myView)
                    return
                    
                }

                for document in querySnapshot!.documents {

                    let dictionary = document.data() as NSDictionary
                    let name = dictionary["name"] as! String
                    let studentID = dictionary["uid"] as! String
                    let curso = dictionary["class"] as! String
                    self.dataRowTable.append(Alumnos.init(nombre: name, escuela: "", tutor: "", curso: curso, direccion: "", telefono: "", correo: "", ID: studentID))
                }
                

                
            }
            self.tableViewStudents.reloadData()
            self.dismissProgressView(myView: self.myView)
        }
        
    }
    
    func removeStudents(index: Int){
        
        db.collection(FirebaseCollection.studentData).document(dataRowTable[index].ID).delete() { err in
            if let err = err {
                print("Error removing in students_data document: \(err)")
            } else {
                print("Document successfully  in students_data removed!")
            }
        }
        
        db.collection(FirebaseCollection.studentsDataPaymentHistory).document(self.dataRowTable[index].ID).delete() { err in
            if let err = err {
                print("Error removing in students_data_payment document: \(err)")
            } else {
                print("Document successfully in students_data_payment removed!")
                
            }
        }
        
        self.dataRowTable.append(Alumnos.init(nombre: "", escuela: "", tutor: "", curso: "", direccion: "", telefono: "", correo: "", ID: ""))
        self.searchBar.isUserInteractionEnabled = false
        self.tableViewStudents.isUserInteractionEnabled = false
        self.tableViewStudents.reloadData()
    }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == SegueIdentifiers.addNewStudent && studentToDetails != "nil"{
            let destinationVC = segue.destination as! AddNewStudentViewController
            //Pasar el studentToDetails a DetailUserCCE
            destinationVC.name = studentToDetails
            destinationVC.idStudent = idStudent
            studentToDetails = "nil"
            idStudent = "nil"

        }
    }
    
    @IBAction func exitAction(_ sender: Any) {
        
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)

            if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LogginCCE") as? LogginCCE {
                    self.present(viewController, animated: true, completion: nil)
                    UserDefaults.standard.removeObject(forKey: "isLogged")
                    }
           }
   
}

extension PrincipalCCE: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            
            return filterDataRowTable.count
            
        }
        
        return dataRowTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataRowTable[indexPath.row].nombre == ""{
            let cell = tableViewStudents.dequeueReusableCell(withIdentifier: "cellNoUser") as! NoPersonTableViewCell
            return cell
        }
        
        let cell = tableViewStudents.dequeueReusableCell(withIdentifier: "cellUser") as! CellUsersTableViewCell
        
        if isSearching {
            
            cell.lblNameCell.text = filterDataRowTable[indexPath.row].nombre
            cell.lblSubtitleCell.text = filterDataRowTable[indexPath.row].curso
            
        }else{
        
        cell.lblNameCell.text = dataRowTable[indexPath.row].nombre
        cell.lblSubtitleCell.text = dataRowTable[indexPath.row].curso
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if dataRowTable[indexPath.row].nombre == ""{
            return 135
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSearching {

            studentToDetails = filterDataRowTable[indexPath.row].nombre
            idStudent = filterDataRowTable[indexPath.row].ID
            
        }else{
         studentToDetails = dataRowTable[indexPath.row].nombre
        idStudent = dataRowTable[indexPath.row].ID
        }
        performSegue(withIdentifier: "segueAddNew", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.removeStudents(index: indexPath.row)
            self.dataRowTable.remove(at: indexPath.row)
            self.tableViewStudents.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    
}

extension PrincipalCCE: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            
            isSearching = false
            view.endEditing(true)
            tableViewStudents.reloadData()
            
        }else{
            
            isSearching = true
            filterDataRowTable = dataRowTable.filter({$0.nombre.range(of: searchBar.text!, options: .caseInsensitive) != nil})
            tableViewStudents.reloadData()
            
        }
    }
}
extension PrincipalCCE {
    func setupFirebase(){
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    func setupUI(){
        
        tableViewStudents.delegate = self
        tableViewStudents.dataSource = self
        tableViewStudents.tableFooterView = UIView()
        
        searchBar.delegate = self
        
        
        self.navigationItem.title = NavigationTitle.home
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
    }
}
