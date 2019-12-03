//
//  UnitsRepasaViewController.swift
//  Prepaton
//
//  Created by Elektra Natchos on 8/1/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit

class UnitsRepasaViewController: UIViewController {

    @IBOutlet weak var unitsTableView: UITableView!
    
    var materia : Materia?
    lazy var selectedUnit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Basic configuration for the views
        unitsTableView.delegate = self
        unitsTableView.dataSource = self
        unitsTableView.backgroundColor = .clear
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        unitsTableView.separatorColor = .clear
        unitsTableView.rowHeight = 120
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
        var questionsToSend = [Pregunta]()
        for lesson in materia?.unidad[selectedUnit].modulo ?? [Modulo()] {
                questionsToSend.append(contentsOf: lesson.pregunta)
        }
        quizVC.questions = questionsToSend
        quizVC.comesFromLecciones = false
    }
    
    //This action allows to get back to this ViewController when the lesson is over
    @IBAction func unwindToUnitsRepasa(_ sender: UIStoryboardSegue){
        
    }
    
}

//Extension for the TableView Protocols and related methods
extension UnitsRepasaViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materia?.unidad.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.unitsTableView.dequeueReusableCell(withIdentifier: "LessonsTableViewCell", for: indexPath) as! LessonsTableViewCell
        cell.lessonNameLabel.text = materia?.unidad[indexPath.row].unidadName
        cell.scoreLabel.text = "Puntuación: " + String(materia!.unidad[indexPath.row].score)
        cell.setStars(for: materia!.unidad[indexPath.row].score)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.setBackground(for: indexPath.row)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUnit = indexPath.row
        performSegue(withIdentifier: "toRepasaQuizVC", sender: self)
    }
   
    
}
