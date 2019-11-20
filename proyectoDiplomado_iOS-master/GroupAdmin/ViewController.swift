//
//  ViewController.swift
//  GroupAdmin
//  Copyright © 2019 Patricia Del Valle. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var fecha: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    var listaGrupo: [NSManagedObject] = []
    var listaGrupoAsistencia : [NSManagedObject] = []
    var myFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "miCelda")
        tableView.dataSource = self
        tableView.delegate = self
        fecha.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
    
//        borraDatosFecha(selectFecha: generaFecha())
    }
    @objc func datePickerValueChanged(sender : UIDatePicker) {
        tableView.reloadData()
    }
    func actualizaTabla()
    {
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
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //ACTUALIZACION DE LA TABLA CON PERSISTENCIA DE DATOS
        actualizaTabla()
        tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaGrupo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "miCelda", for: indexPath)
        
        // Configure the cell
        let unAlumno = listaGrupo[indexPath.row] //se extrae el valor
        cell.textLabel?.text = unAlumno.value(forKeyPath: "nombre") as? String
        if llenaAsistencia(row:indexPath.row ){
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    func llenaAsistencia(row : Int) -> Bool{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false}
        let managedContext = appDelegate.persistentContainer.viewContext
        let estudianteFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Asistencia")
        estudianteFetchRequest.predicate = NSPredicate(format: "cuenta = %@ and fecha = %@", listaGrupo[row].value(forKey: "cuenta")  as!  String, generaFecha())
        do {
            listaGrupoAsistencia = try managedContext.fetch(estudianteFetchRequest) as! [NSManagedObject]
            for elemento in listaGrupoAsistencia {
                if elemento.value(forKeyPath: "estado")  as!  CBool == false {
                    return false
                }
            }
            
        } catch { print (print ("results de asistencia ----> \(error)"))}

        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark{
                cell.accessoryType = .none
                updateAsistencia(alumno: listaGrupo[indexPath.row], estado: false, selectFecha: generaFecha())
            }
            else {
                cell.accessoryType = .checkmark
                updateAsistencia(alumno: listaGrupo[indexPath.row], estado: true, selectFecha: generaFecha())
            }

        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAccion = UIContextualAction(style: .destructive, title: "Borrar") { (accion, sourceView, completionHendler) in
            let nom = self.listaGrupo[indexPath.row].value(forKey: "nombre") as!  String
            self.listaGrupo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHendler(true)
            self.deleteAlumno(nombre: nom)
        }
        //configurar el parametro de retorno
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [ deleteAccion])
        return swipeConfiguration
    }
    
    func generaFecha() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        let selectedDate = dateFormatter.string(from: fecha.date)
        return selectedDate
    }
    
      //PERSISTENCIA COREDATA
    //=====================
    
    func updateAsistencia(alumno: NSManagedObject, estado: Bool, selectFecha: String) {
        //1. Obtener el contenedor,referencia al delegado de la aplicación.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //2. Crear el contexto del contenedor. NSManagedObjectContext.
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3.
        let estudianteFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Asistencia")
        //estudianteFetchRequest.predicate = NSPredicate(format: "cuenta = %@ ",alumno.value(forKey: "cuenta")  as!  String)
        estudianteFetchRequest.predicate = NSPredicate(format: "cuenta = %@ and fecha = %@",alumno.value(forKey: "cuenta")  as!  String, selectFecha)
        do {
            let resultado = try managedContext.fetch(estudianteFetchRequest)
            if resultado.isEmpty {
                guard let myEntity = NSEntityDescription.entity(forEntityName: "Asistencia", in: managedContext) else { return }
                let nuevoObjeto = NSManagedObject(entity: myEntity, insertInto: managedContext)
                
                //3. Extraer los datos con el atributo utilizando codificacion clave:valor
 
                nuevoObjeto.setValue(selectFecha, forKey: "fecha")
                nuevoObjeto.setValue(alumno.value(forKey: "cuenta"), forKey: "cuenta")
                nuevoObjeto.setValue(alumno.value(forKeyPath: "nombre"), forKey: "nombre")
                nuevoObjeto.setValue(estado, forKeyPath: "estado")
                //  4. Se almacenan los datos en disco con save
                do {
                    try managedContext.save()
                    
                } catch let error as NSError {
                    print("Error: No se registro el alumno en la lista de asistencia. \(error.userInfo)")
                }
            }
            else {
                    //let resultado = try managedContext.fetch(estudianteFetchRequest)
                    let objectUpdate = resultado[0] as! NSManagedObject
                    objectUpdate.setValue(estado, forKey: "estado")
                    do {
                        try managedContext.save()
                    }catch {print (error)}
                
           }
        } catch { print (error)}
}
    
    func asignaAsistencia(){
        
    }
    func updateAlumno(nombre:String, falta: Int64) {
        //1. Obtener el contenedor,referencia al delegado de la aplicación.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //2. Crear el contexto del contenedor. NSManagedObjectContext.
        
        let managedContext = appDelegate.persistentContainer.viewContext

        //3.
        let estudianteFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Estudiante")
        estudianteFetchRequest.predicate = NSPredicate(format: "nombre = %@",nombre)
        do {
            let resultado = try managedContext.fetch(estudianteFetchRequest)
            let objectUpdate = resultado[0] as! NSManagedObject
            objectUpdate.setValue(falta, forKey: "faltas")
            do {
                try managedContext.save()
            }catch {print (error)}
        } catch { print (error)}
    }
    func deleteAlumno(nombre:String) {
        //1.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //2.
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3.
        let estudianteFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Estudiante")
        estudianteFetchRequest.predicate = NSPredicate(format: "nombre = %@",nombre)
        do {
            let resultado = try managedContext.fetch(estudianteFetchRequest)
            let objectDelete = resultado[0] as! NSManagedObject
            managedContext.delete(objectDelete)
            do {
                try managedContext.save()
            }catch {print (error)}
        } catch { print (error)}
    }
    func borraDatosFecha(selectFecha:String) {
        //1.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //2.
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3.
        let estudianteFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Asistencia")
        //estudianteFetchRequest.predicate = NSPredicate(format: "fecha = %@",selectFecha)
        do {
            let request = NSBatchDeleteRequest(fetchRequest: estudianteFetchRequest)
            //let resultado = try managedContext.fetch(estudianteFetchRequest)
            let resultado = try managedContext.execute(request)
            do {
                try managedContext.save()
            }catch {print (error)}
        } catch { print (error)}
    }
    
    @IBAction func addStudent(_ sender: UIBarButtonItem) {
        //1. CREAR ALERTA
        let alert = UIAlertController(title: "Alta", message: "Adicionar un alumno", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        
        //2. AGREGAR ACCIONES
        let saveAction = UIAlertAction(title: "Guardar", style: .default, handler: {
            action in
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {return }
            guard let textFieldCuenta = alert.textFields?[1],
                let cuentaToSave = textFieldCuenta.text else {return }
            
            //self.listaGrupo.append(nameToSave)
            // cambiar por esta linea:
            self.registrarAlumno(name:nameToSave, cuenta: cuentaToSave)
            self.tableView.reloadData()
        })
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        //3. PRESENTAR ALERTA
        self.present(alert, animated: true, completion: nil)
    }
    func registrarAlumno(name: String, cuenta: String){
    }

}

