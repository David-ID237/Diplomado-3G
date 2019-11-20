//
//  RegistroAlumnoViewController.swift
//  GroupAdmin

//  Copyright © 2019 Patricia Del Valle. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class RegistroAlumnoViewController: UIViewController {

    @IBOutlet weak var numCuenta: UITextField!
    @IBOutlet weak var nombre: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func registrarAlumno(_ sender: UIButton) {
        if (numCuenta.text!.isEmpty || nombre.text!.isEmpty){
            let alert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
            let msgFont = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24)]
            let msgString = NSAttributedString(string: "Debe llenar los campos solicitados", attributes:msgFont)
            
            // alert.setValue(titleString, forKey: "attributedTitle")
            alert.setValue(NSAttributedString(string: "Error:", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30), NSAttributedString.Key.foregroundColor: UIColor.red]), forKey: "attributedTitle" )
            alert.setValue(msgString, forKey: "attributedMessage")
            
            //2. AGREGAR ACCIONES
            let saveAction = UIAlertAction(title: "OK", style:.default)
            alert.addAction(saveAction)
            
            //3. PRESENTAR ALERTA
            self.present(alert, animated: true, completion: nil)
        }
        else {
            //1. primero obtienes una referencia al delegado de la aplicación.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            //2. para guardar o recuperar del almacén de Core Data, primero debe tener en sus manos un archivo NSManagedObjectContext. Este contexto de objeto gestionado por defecto vive como una propiedad del NSPersistentContainer delegado de la aplicación.
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //3. Verifica que no este registrado el numero de cuenta del estudiante
            let estudianteFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Estudiante")
            estudianteFetchRequest.predicate = NSPredicate(format: "cuenta = %@",numCuenta.text!)
            do {
                let resultado = try managedContext.fetch(estudianteFetchRequest)
                if resultado.isEmpty {
                    //2. Crea un nuevo objeto gestionado y lo inserta en el contexto del objeto gestionado. Se puede hacer esto en un solo paso con NSManagedObjectel método estático de entity(forEntityName:in:).
                    
                    guard let myEntity = NSEntityDescription.entity(forEntityName: "Estudiante", in: managedContext) else { return }
                    let unAlumno = NSManagedObject(entity: myEntity, insertInto: managedContext)
                    
                    //3. Extraer los datos con el atributo name utilizando codificacion clave:valor
                    unAlumno.setValue(nombre.text, forKeyPath: "nombre")
                    unAlumno.setValue(numCuenta.text, forKeyPath: "cuenta")
                    
                    
                    //  4. Se almacenan los datos en disco con save y se inserta en la lista
                    do {
                        try managedContext.save()
                        //listaGrupo.append(unAlumno)
                        let alert = UIAlertController(title: "Registro", message: "", preferredStyle: .alert)
                        let msgFont = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30)]
                        let msgString = NSAttributedString(string: "Alumno registrado", attributes:msgFont)
                        
                        // alert.setValue(titleString, forKey: "attributedTitle")
                        alert.setValue(NSAttributedString(string: "Registro:", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30), NSAttributedString.Key.foregroundColor: UIColor.red]), forKey: "attributedTitle" )
                        alert.setValue(msgString, forKey: "attributedMessage")
                        
                        //2. AGREGAR ACCIONES
                        let saveAction = UIAlertAction(title: "OK", style:.default)
                        alert.addAction(saveAction)
                        
                        //3. PRESENTAR ALERTA
                        self.present(alert, animated: true, completion: nil)
                        self.nombre.text = ""
                        self.numCuenta.text = ""
                        
                    } catch let error as NSError {
                        print("Error: No se registro el alumno en la lista. \(error.userInfo)")
                    }
                }
                else {
                    let alert = UIAlertController(title: "Error", message: "No se puede registrar el estudiante. El número de cuenta ya esta esta registrado en la BD, verificar datos......", preferredStyle: .alert)
                    
                     let msgFont = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24)]
                    let msgString = NSAttributedString(string: "Número de cuenta duplicado, verificar datos...", attributes:msgFont)
                    
                   // alert.setValue(titleString, forKey: "attributedTitle")
                    alert.setValue(NSAttributedString(string: "Error:", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30), NSAttributedString.Key.foregroundColor: UIColor.red]), forKey: "attributedTitle" )
                    alert.setValue(msgString, forKey: "attributedMessage")
                    
                    //2. AGREGAR ACCIONES
                    let saveAction = UIAlertAction(title: "OK", style:.default)
                    alert.addAction(saveAction)
                    alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel , handler: {
                        action in
                        self.nombre.text = ""
                        self.numCuenta.text = ""
                    }))
                    
                    //3. PRESENTAR ALERTA
                    self.present(alert, animated: true, completion: nil)
                }
            } catch { print (error)}
        }
    }
    
    
    @IBAction func cancelarButton(_ sender: UIButton) {
        self.nombre.text = ""
        self.numCuenta.text = ""
    }
    
}
