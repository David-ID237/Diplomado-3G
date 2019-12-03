//
//  UnitsTableViewController.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/28/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit

class UnitsTableViewController: UIViewController {

    @IBOutlet weak var unitsTableView: UITableView!
    
    var materia : Materia?
    lazy var selectedUnit = 0
    lazy var selectedLesson = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Basic configuration for the views
        unitsTableView.delegate = self
        unitsTableView.dataSource = self
        unitsTableView.backgroundColor = .clear
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        unitsTableView.separatorColor = .clear
        //Gets the instance materia of type Materia from the TabBarController
        let tabBar = tabBarController as! myTabBarController
        materia = tabBar.materia
    }
    
    override func viewWillAppear(_ animated: Bool) {
        unitsTableView.reloadData()
        navigationController?.isNavigationBarHidden = true
        tabBarController?.navigationController?.isNavigationBarHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizVC = segue.destination as! LeccionesQuizVC
        quizVC.questions = materia?.unidad[selectedUnit].modulo[selectedLesson-1].pregunta ?? [Pregunta]()
        quizVC.comesFromLecciones = true
    }
    
    //This action allows to get back to this ViewController when the lesson is over
    @IBAction func unwindToUnits(_ sender: UIStoryboardSegue){
        
    }
}

//Extension for the TableView Protocols and related methods
extension UnitsTableViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return materia?.unidad.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (materia?.unidad[section].modulo.count ?? 0) + 1
    }
    
    //Determines if the cell is going to be a header or a lessonCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = unitsTableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            cell.unitNameLabel.text = materia?.unidad[indexPath.section].unidadName
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        }else{
            let cell = unitsTableView.dequeueReusableCell(withIdentifier: "LessonsTableViewCell", for: indexPath) as! LessonsTableViewCell
            cell.lessonNameLabel.text = materia?.unidad[indexPath.section].modulo[indexPath.row-1].moduleName
            cell.scoreLabel.text = "Puntuación: " +  String(materia!.unidad[indexPath.section].modulo[indexPath.row-1].score)
            cell.setStars(for: materia!.unidad[indexPath.section].modulo[indexPath.row-1].score)
            cell.setBackground(for: indexPath.section)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 1{
        selectedUnit = indexPath.section
        selectedLesson = indexPath.row
        performSegue(withIdentifier: "toQuizVC", sender: self)
        }
    }
    //Sets the height for the cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return CGFloat(30)
        }else {
            return CGFloat(120)
        }
    }
    
}

