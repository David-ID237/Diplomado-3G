//
//  calificacionesViewController.swift
//  GroupAdmin

//  Copyright © 2019 Patricia Del Valle. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class calificacionesViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    var calificacionesGrupo: [NSManagedObject] = []
    var myFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
 
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "celdaCalif")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func actualizaLista()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let estudiantesFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Estudiante")
        estudiantesFetchRequest.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        do {
            calificacionesGrupo = try managedContext.fetch(estudiantesFetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //ACTUALIZACION DE LA TABLA CON PERSISTENCIA DE DATOS
        actualizaLista()
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calificacionesGrupo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "unaCelda", for: indexPath) as! CalificacionesTableViewCell
        let unAlumno = calificacionesGrupo[indexPath.row] //se extrae el valor
        cell.cuentaLabel.text = unAlumno.value(forKey: "cuenta") as? String
        cell.nombreLabel.text = unAlumno.value(forKeyPath: "nombre") as? String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func getPromedio(elemento : NSManagedObject) -> CGFloat{
        return CGFloat(((elemento.value(forKeyPath: "parcial1") as? Float)! + (elemento.value(forKeyPath: "parcial2") as? Float)! + (elemento.value(forKeyPath: "parcial3") as? Float)!)/3.0)
    }
}
