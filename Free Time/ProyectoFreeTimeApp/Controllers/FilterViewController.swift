//
//  FilterViewController.swift
//  ProyectoFreeTimeApp
//
//  Created by Rodrigo Vivas y Noemí Rodríguez on 8/10/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate, UINavigationBarDelegate {

    @IBOutlet weak var radioButton1: UIButton!
    @IBOutlet weak var radioButton2: UIButton!
    @IBOutlet weak var radioButton3: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var placesArray = ["Todos","MUAC", "CCU", "Museo Universitario del Chopo"]
    
    var selectedPlace = "Todos"
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        navBar.delegate = self
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
    }
    
    @IBAction func selectRButton1(_ sender: UIButton) {
        if radioButton2.isSelected || radioButton3.isSelected{
            radioButton1.isSelected = true
            radioButton2.isSelected = false
            radioButton3.isSelected = false
        }else{
            radioButton1.isSelected = true
        }
    }
    @IBAction func selectRButton2(_ sender: UIButton) {
        if radioButton1.isSelected || radioButton3.isSelected{
            radioButton1.isSelected = false
            radioButton2.isSelected = true
            radioButton3.isSelected = false
        }else{
            radioButton2.isSelected = true
        }
    }
    @IBAction func selectRButton3(_ sender: Any) {
        if radioButton1.isSelected || radioButton2.isSelected{
            radioButton1.isSelected = false
            radioButton2.isSelected = false
            radioButton3.isSelected = true
        }else{
            radioButton3.isSelected = true
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return placesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return placesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPlace = placesArray[row]
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
