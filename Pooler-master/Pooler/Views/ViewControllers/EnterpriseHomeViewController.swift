//
//  EnterpriseHomeViewController.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/12/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import UIKit
import Firebase

class EnterpriseHomeViewController: UIViewController {
    
    var enterprise = Enterprise()
    var ref = Database.database().reference(withPath: "users")
    var arrInactiveEmployees:[Employee] = []{
        didSet{
            self.employeesTableView.reloadData()
            dismiss(animated: true, completion: nil)
        }
    }
    var indicator = UIActivityIndicatorView()
    
    @IBOutlet weak var profileDetailView: ProfileDetail!
    @IBOutlet weak var employeesTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Inicio"
        employeesTableView.delegate = self
        employeesTableView.dataSource = self
        profileDetailView.nameLabel.text = enterprise.name
        profileDetailView.profileImageView.image =  self.enterprise.profileImage!.base64ToImage()
        waitScreen()
       
        self.getInactiveEmployees()
        
        
        self.indicator.hidesWhenStopped = true
        
       
    }
    
    func waitScreen()  {
        let alert = UIAlertController(title: nil, message: "Cargando datos...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
   
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.employeesTableView.reloadData()
//        
//        
//    }
    
    func getInactiveEmployees() {
        DispatchQueue.main.async {
            self.ref.queryOrdered(byChild: "enterprise").queryEqual(toValue: self.enterprise.UID).observeSingleEvent(of: .value, with: { [weak self](snapshot) in
                for child in snapshot.children {
                    let myChild = child as! DataSnapshot
                    if let myChildValue = myChild.value as? [String:Any]{
                        var temEmployee = Employee()
                        temEmployee.active = myChildValue["active"] as? Int
                        temEmployee.name = myChildValue["name"] as? String ?? ""
                        temEmployee.email = myChildValue["email"] as? String ?? ""
                        temEmployee.phone = myChildValue["phone"] as? String ?? ""
                        temEmployee.profileImage = myChildValue["profileImage"] as? String ?? ""
                        self!.arrInactiveEmployees.append(temEmployee)
                    }
                }
                }, withCancel: nil)
        }
        
        
    }
    
    
    
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
}

extension EnterpriseHomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInactiveEmployees.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as? EmployeeTableViewCell
        cell!.empNameLbl.text = arrInactiveEmployees[indexPath.row].name
        cell!.employeeImageView.image = arrInactiveEmployees[indexPath.row].profileImage!.base64ToImage()!
        cell!.emailLbl.text = arrInactiveEmployees[indexPath.row].email
        cell!.phoneLbl.text = arrInactiveEmployees[indexPath.row].phone
        cell?.activeSwitch.isOn = NSNumber(value: arrInactiveEmployees[indexPath.row].active!) as! Bool
        return cell!
    }
}
