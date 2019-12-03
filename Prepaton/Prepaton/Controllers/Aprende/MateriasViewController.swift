//
//  MateriasViewController.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/10/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit

class MateriasViewController: UIViewController{
    
    @IBOutlet weak var ModulesTableView: UITableView!

    var materias = Materia().setInitialModules()
    lazy var selectedCourse = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Basic configuration for the views
        ModulesTableView.delegate = self
        ModulesTableView.dataSource = self
        ModulesTableView.rowHeight = 145
        ModulesTableView.separatorColor = .clear
        navigationItem.title = "Materias"
        updateScores()//updates the scores for the lessons with UserDefaults
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ModulesTableView.reloadData()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tbc = segue.destination as? myTabBarController
        tbc?.materia = materias[selectedCourse]
    }
}

//Extension used for TableView Protocols and related methods
extension MateriasViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ModulesTableView.dequeueReusableCell(withIdentifier: "MateriasTableViewCell", for: indexPath) as! MateriasTableViewCell
        cell.backgroundColor = .clear
        cell.materiaLabel.text = materias[indexPath.row].materia
        cell.materiaImage.image = UIImage(named: materias[indexPath.row].imgName)
        cell.selectionStyle = .none
        cell.setBackground(for: indexPath.row)

        return cell
    }
    
    //Called when user selects a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCourse = indexPath.row
            performSegue(withIdentifier: "toTabBar", sender: self)
    }
}

//Extension for the UserDefaults methods
extension MateriasViewController {
    //Checks if there is a preexistent score for the lessons, if there aint, it sets the score to 0
    func updateScores(){
        for materia in materias {
            for unidad in materia.unidad {
                    unidad.score = UserDefaults.standard.integer(forKey: unidad.unidadName)
                for lesson in unidad.modulo {
                    lesson.score = UserDefaults.standard.integer(forKey: lesson.moduleName)
                }
            }
        }
    }
}
