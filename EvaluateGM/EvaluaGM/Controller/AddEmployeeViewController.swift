//
//  AddEmployeeViewController.swift
//  EvaluateGM
//
//  Created by José Antonio Arellano Mendoza on 6/28/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import UIKit

class AddEmployeeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Properties
    let pickerData = ["Montacarga", "Reparto", "Ayudante de almacén", "Ayudante de reparto"]
    var employee = Employee(name: "Name", lastName: "lastName", type: .forklift)
    var index = 0
    var imagePicker: ImagePicker!
    
    //Outlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //Actions
    @IBAction func nameTextFieldChange(_ sender: UITextField) {
        if sender.text?.count != 0 && lastNameTextField.text?.count != 0{
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    @IBAction func lastNameTextFieldChange(_ sender: UITextField) {
        if sender.text?.count != 0 && nameTextField.text?.count != 0{
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    @IBAction func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
        pickerView.endEditing(true)
    }
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
    }
    
    //Methods
    func setupUI() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.heightAnchor.constraint(equalToConstant: 30 + imageView.frame.height / 2).isActive = true
        
        if nameTextField.text?.count != 0 && lastNameTextField.text?.count != 0{
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        
        imageView.layer.borderWidth = 6.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
        imageView.image = employee.photo
        
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10).isActive = true
        cameraButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10).isActive = true
        cameraButton.layer.borderWidth = 1.0
        cameraButton.layer.masksToBounds = false
        cameraButton.layer.borderColor = UIColor.white.cgColor
        cameraButton.layer.cornerRadius = cameraButton.frame.size.height / 2
        cameraButton.clipsToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let name = nameTextField.text, let lastName = lastNameTextField.text else {
            return
        }
        employee.name = name
        employee.lastName = lastName
        employee.type = setEmployeeType()
    }
    
    func setEmployeeType() -> Type{
        switch index {
        case 0:
            return .forklift
        case 1:
            return .delivery
        case 2:
            return .warehouseAssistant
        case 3:
            return .deliveryAssistant
        default:
            return .forklift
        }
    }
}

extension AddEmployeeViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let imageSelected = image else {
            return
        }
        employee.photo = imageSelected
        setupUI()
    }
}
