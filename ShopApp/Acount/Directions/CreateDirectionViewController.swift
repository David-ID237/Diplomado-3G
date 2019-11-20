//
//  CreateDirectionViewController.swift
//  shopapp
//
//  Created by David on 8/7/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class CreateDirectionViewController: UIViewController {

    
    @IBOutlet weak var aliasDirectionTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var exteriorNumberTextField: UITextField!
    @IBOutlet weak var interiorNumberTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var colonyTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    var direction: Direction?
    var idCell: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
        if let dir = self.direction {
            aliasDirectionTextField.text = dir.alias
            streetTextField.text = dir.avenue
            exteriorNumberTextField.text = dir.outdoorNumber
            interiorNumberTextField.text = dir.interiorNumber
            zipCodeTextField.text = dir.zp
            colonyTextField.text = dir.colony
            townTextField.text = dir.town
            stateTextField.text = dir.state
            phoneTextField.text = dir.phone
        }
    }
        
    @IBAction func saveDirectionButtonAction(_ sender: Any) {
        if checkTextField(fields: [aliasDirectionTextField, streetTextField, exteriorNumberTextField, interiorNumberTextField, zipCodeTextField, townTextField, colonyTextField, stateTextField, phoneTextField]) && validations() {
            guard let alias = aliasDirectionTextField.text, let avenue = streetTextField.text, let outdoorNumber = exteriorNumberTextField.text, let interiorNunmber = interiorNumberTextField.text, let zp = zipCodeTextField.text, let colony = colonyTextField.text, let town = townTextField.text, let state = stateTextField.text, let phone = phoneTextField.text else { return }
            let direction = Direction(alias: alias, avenue: avenue, outdoorNumber: outdoorNumber, interiorNumber: interiorNunmber, zp: zp, colony: colony, town: town, state: state, phone: phone)
            
            if self.direction == nil {
                ShopCart.shared.directions.append(direction)
            } else {
                guard let idCell = self.idCell else { return }
                ShopCart.shared.directions[idCell] = direction
            }
            ShopCart.shared.saveDirectionStorage()
            
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    private func checkTextField(fields: [UITextField]) -> Bool {
        var validate = true
        for textField in fields {
            if textField.text?.count == 0 {
                errorTextField(field: textField)
                validate = false
            } else {
                textField.layer.borderWidth = 0.0
                //textField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        return validate
    }
    
    private func errorTextField(field: UITextField) {
        field.layer.borderColor = UIColor.red.cgColor
        field.layer.borderWidth = 1.0
        field.shake()
    }
    
    private func validations() -> Bool {
        var validate = true
        guard let phone = phoneTextField.text, let zipCode = zipCodeTextField.text else { return false }
        if phone.count < 8 || phone.count > 10 {
            errorTextField(field: phoneTextField)
            validate = false
        }
        if zipCode.count != 5 {
            errorTextField(field: zipCodeTextField)
            validate = false
        }
        return validate
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
