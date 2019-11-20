//
//  ReporteAsistenciaViewController.swift
//  GroupAdmin

//  Copyright © 2019 Patricia Del Valle. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ReporteAsistenciaViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    var listaGrupo: [NSManagedObject] = []
    var repoGrupo : [Alumno] = []
    
    var myFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "miCeldaRepo")
        tableView.dataSource = self
        tableView.delegate = self
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //repoGrupo = []
        //listar()
        loadTable()
        tableView.reloadData()
    }

    
    func loadTable() {
        //ACTUALIZACION DE LA TABLA CON PERSISTENCIA DE DATOS
        //1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let estudiantesFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Estudiante")
        estudiantesFetchRequest.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        
        //3
        
        do {
            listaGrupo = try managedContext.fetch(estudiantesFetchRequest)
            repoGrupo = []
            for elemento in listaGrupo{
                let promedio = getPromedio(elemento: elemento)
                let faltas = getFaltas(cuenta : elemento.value(forKeyPath: "cuenta") as? String as Any as! String, estado: false)
                repoGrupo.append (Alumno (cuenta: elemento.value(forKeyPath: "cuenta") as? String as Any as! String, nombre: (elemento.value(forKeyPath: "nombre") as? String)!, parcial1: (elemento.value(forKeyPath: "parcial1") as? Float)! , parcial2: (elemento.value(forKeyPath: "parcial2") as? Float)!, parcial3: (elemento.value(forKeyPath: "parcial3") as? Float)!, promedio: promedio, faltas: faltas))

                
                }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func getPromedio(elemento : NSManagedObject) -> Float{
        return ((elemento.value(forKeyPath: "parcial1") as? Float)! + (elemento.value(forKeyPath: "parcial2") as? Float)! + (elemento.value(forKeyPath: "parcial3") as? Float)!)/3.0
    }
    
    func listar(){
       var listaGrupoAsistencia : [NSManagedObject] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //VERIFICANDO
        var estudianteFetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Asistencia")
        estudianteFetchRequest2.predicate = NSPredicate(format: "cuenta = %@ and estado = %@","1111","false")
        estudianteFetchRequest2.sortDescriptors = [NSSortDescriptor(key: "fecha", ascending: true)]
//        estudianteFetchRequest2.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        
        
        do {
            listaGrupoAsistencia = try managedContext.fetch(estudianteFetchRequest2) as! [NSManagedObject]
            for elemento in listaGrupoAsistencia{
                
                print (elemento.value(forKeyPath: "fecha") as? String as Any, elemento.value(forKeyPath: "nombre") as? String as Any, elemento.value(forKeyPath: "estado") as? Bool?, Int16(listaGrupoAsistencia.count))
            
            }
        } catch { print (print ("results de asistencia ----> \(error)"))}

        
        
        
    }
    func getFaltas(cuenta: String, estado: Bool) -> Int16{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return 0}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let estudianteFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Asistencia")
        estudianteFetchRequest.predicate = NSPredicate(format: "cuenta = %@ and estado = %@",cuenta,"false")
        do {
            let resultado = try managedContext.fetch(estudianteFetchRequest)
//            if resultado.isEmpty { print ("Sin registro de faltas...")}
//            print (Int16(resultado.count)) //"\(resultado[0].value(forKey: "cuenta")) \(Int16(resultado.count))")
            return Int16(resultado.count)
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaGrupo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "miCeldaRepo", for: indexPath) as! ReporteAsistenciaTableViewCell
        
        // Configure the cell
        let unAlumno = repoGrupo[indexPath.row] //se extrae el valor
        cell.cuenta.text = unAlumno.cuenta
    
        cell.labelNombreCell.text = unAlumno.nombre
        cell.labelFaltasCell.text = String(unAlumno.faltas)
    
        //tableView.reloadData()
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
