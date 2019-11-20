//
//  FirstLaunchController.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/5/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import Foundation
import UIKit

class FirstLaunchController :  UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    //Outlets
    @IBOutlet weak var typeOfUserPicker: UIPickerView!
    @IBOutlet weak var beginBtn: UIButton!
    
    //Variables
    var pickerData = [String]()
    var user:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["Empresa", "Empleado"]
        self.typeOfUserPicker.delegate = self
        self.typeOfUserPicker.dataSource = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        user = pickerData[row]
    }
    
    
    @IBAction func goToRegisterorLogin(_ sender: Any) {
        user = String(pickerData[typeOfUserPicker.selectedRow(inComponent: 0)]).uppercased()
        if  user == "EMPLEADO"  {
            if let employeeRegVC = self.storyboard?.instantiateViewController(withIdentifier: "employeeRegVC") as? EmployeeRegisterViewController {
                self.navigationController?.show(employeeRegVC, sender:nil)
            }
        }else if user == "EMPRESA" {
            if let enterpriseRegVC = self.storyboard?.instantiateViewController(withIdentifier: "enterpriseRegVC") as? EnterpriseRegisterViewController {
                 self.navigationController?.show(enterpriseRegVC, sender:nil)
            }
        }
        

        
        
        
    }
    
}
