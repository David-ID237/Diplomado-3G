//
//  NewRouteViewController.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/11/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class NewRouteViewController: UIViewController,UINavigationControllerDelegate {
    
    var route = Route()
    var pickerData: [String] = [String]()
    var days:String = ""
    let ref = Database.database().reference (withPath: "routes")
    
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var sitsPicker: UIPickerView!
    @IBOutlet weak var mondaySwitch: UISwitch!
    @IBOutlet weak var tuesdaySwitch: UISwitch!
    @IBOutlet weak var wednesdaySwitch: UISwitch!
    @IBOutlet weak var thursdaySwitch: UISwitch!
    @IBOutlet weak var fridaySwitch: UISwitch!
    @IBOutlet weak var satudaySwitch: UISwitch!
    @IBOutlet weak var sundaySwitch: UISwitch!
    @IBOutlet weak var feeTextField: UITextField!
    @IBOutlet weak var departureDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        route.employee = Employee()
        route.enterprise = Enterprise()
        route.address = Location()
        self.sitsPicker.delegate = self
        self.sitsPicker.dataSource = self
        navigationItem.title = "Nueva ruta"
        pickerData = ["1", "2", "3", "4", "5", "6"]
        let defaults = UserDefaults.standard
        route.employee?.UID = defaults.string(forKey: "employeeUID")
        route.enterprise?.UID = defaults.string(forKey: "enterpriseUID")
        route.employee?.name = defaults.string(forKey: "employeeName")
        route.employee?.profileImage = defaults.string(forKey: "employeeImage")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    @IBAction func findAddress(_ sender: Any) {
        if let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "mapVC") as? MapViewController {
            self.navigationController?.show(mapVC, sender:nil)
            mapVC.delegate = self
        }
        
        
    }
    
    @IBAction func saveRoute(_ sender: Any) {
        if getDays() == "" {
            let alert = UIAlertController(title: "Selección de días", message: "Debes seleccionar al menos un día para dar de alta la ruta", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        route.days =  getDays()
        if feeTextField.text! == ""{
            let alert = UIAlertController(title: "Cuota por asiento", message: "Ingresa el costo por asiento, indica 0 si será gratis", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        let components = Calendar.current.dateComponents([.hour,.minute,], from: departureDatePicker.date)
        route.departureTimeHour = components.hour
        route.departureTimeMinutes = components.minute
        route.price = Int(feeTextField.text!)
        
        let routeO: Dictionary<String,Any> = ["longitude": route.address!.longitude!,
                                                 "latitude":route.address!.latitude!,
                                                 "addressTitle":route.address!.locationTitle!,
                                                 "addressSubtitle":route.address!.locationSubtitle!,
                                                 "seats": route.seats,
                                                 "days":  route.days!,
                                                 "price": route.price!,
                                                 "ownerName": route.employee!.name!,
                                                 "ownerImage": route.employee!.profileImage!,
                                                 "departureMinutes":route.departureTimeMinutes!,
                                                 "departureHour":route.departureTimeHour!,
                                                 "poolers":"",
                                                 "timestamp":[".sv": "timestamp"],
                                                 "idRoute":ref.key!,
                                                 "enterprise": route.enterprise!.UID!,
                                                 "employee": route.employee!.UID!
                                                 ]
        self.ref.childByAutoId().setValue(routeO) {[weak self](error, result) in
            if let error = error {
                print("Failed to store, with error : ",error.localizedDescription)
                return
            }
            let alertController = UIAlertController(title: "Ruta añadida", message: "La ruta se añadió con éxito", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: {[weak self] (action) in
                    self?.navigationController?.popViewController(animated: true)
                    //                tabBArC.delegate = self
            })
            alertController.addAction(defaultAction)
            self!.present(alertController, animated: true, completion: nil)

        }
//
        
        
        
        
        
        
        
        
    }
    
    
    func getDays() -> String{
        days = ""
        if mondaySwitch.isOn {
            days =  days + "LUNES,"
        }
        if tuesdaySwitch.isOn {
            days =  days + " MARTES,"
        }
        if wednesdaySwitch.isOn {
            days =  days + " MIERCOLES,"
        }
        if thursdaySwitch.isOn {
            days =  days + " JUEVES,"
        }
        if fridaySwitch.isOn {
            days =  days + " VIERNES,"
        }
        if satudaySwitch.isOn {
            days =  days + " SABADO,"
        }
        if sundaySwitch.isOn {
            days =  days + " DOMINGO,"
        }
        if  days.count >= 2{
            days.removeLast()
        }
        return days
    }
    
    
}

extension NewRouteViewController: setAddressDelegate{
    
    func returnAddres(coordinate: CLLocationCoordinate2D,address:MKLocalSearchCompletion) {
        addressTextView.text = address.subtitle
        route.address?.longitude = coordinate.longitude.description
        route.address?.latitude = coordinate.latitude.description
        route.address?.locationTitle = address.title
        route.address?.locationSubtitle = address.subtitle
        
    }
}

extension NewRouteViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        route.seats = Int(pickerData[row])!
    }
}


