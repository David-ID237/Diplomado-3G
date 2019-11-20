//
//  SupervisorsTableViewController.swift
//  Evalúa GM
//
//  Created by José Antonio Arellano Mendoza on 8/6/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SupervisorsTableViewController: UITableViewController {
    
    //Properties
    var supervisors: [User] = []
    var sortedSupervisors: [User] = []
    var ref: DatabaseReference!
    var sectionsHeaders: [String] = ["Promedio de evaluaciones hechas"]
    var sectionsFooters: [String] = ["S/E: Sin evaluaciones hechas"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        readSupervisors()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedSupervisors.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsHeaders[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sectionsFooters[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupervisorCell", for: indexPath)
        
        let supervisor = sortedSupervisors[indexPath.row]
        
        //3. Configuramos celda
        cell.textLabel?.text = "\(supervisor.name) \(supervisor.lastName)"
        if supervisor.hasEvaluated {
            if supervisor.averageIndicator {
                cell.detailTextLabel?.text = "↑ \(String(format: "%.2f", supervisor.getGeneralAverage()))"
            } else {
                cell.detailTextLabel?.text = "↓ \(String(format: "%.2f", supervisor.getGeneralAverage()))"
            }
        } else {
            cell.detailTextLabel?.text = "S/E"
        }
        
        //4. Retornamos celda
        return cell
    }
    
    func readSupervisors() {
        ref.child("users").observe(DataEventType.value) { (snapshot) in
            self.supervisors.removeAll()
            self.tableView.reloadData()
            for supervisor in snapshot.children.allObjects as! [DataSnapshot] {
                let value = supervisor.value as? [String: AnyObject]
                let name = value?["name"] as? String ?? ""
                let lastName = value?["lastName"] as? String ?? ""
                let email = value?["email"] as? String ?? ""
                let password = value?["password"] as? String ?? ""
                let isSupervisor = value?["isSupervisor"] as? Bool ?? false
                let userId = value?["userId"] as? String ?? ""
                let averageArray = value?["averageArray"] as? [Float] ?? []
                let averageIndicator = value?["averageIndicator"] as? Bool ?? true
                var user = User(name: name, lastName: lastName, email: email, password: password, isSupervisor: isSupervisor)
                user.userId = userId
                user.averageArray = averageArray
                user.averageIndicator = averageIndicator
                if user.isSupervisor {
                    self.supervisors.append(user)
                }
            }
            self.sortedSupervisors = self.supervisors.sorted(by: <)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
