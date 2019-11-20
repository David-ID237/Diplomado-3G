//
//  PayViewController.swift
//  shopapp
//
//  Created by David on 8/10/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class PayViewController: UIViewController {

    @IBOutlet weak var directionTextField: DropDownTextField!
    @IBOutlet weak var cvvCardTextField: UITextField!
    @IBOutlet weak var creditCardTextField: UITextField!
    @IBOutlet weak var totalProductsLabel: UILabel!
    @IBOutlet weak var shipCostLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var yearExpTextField: DropDownTextField!
    @IBOutlet weak var monthExpTextField: DropDownTextField!
    @IBOutlet weak var cardHolderTextField: UITextField!
    
    var directionsArr: [Direction] = [Direction]()
    var products: [Product] = ShopCart.shared.products
    var selectedDirection: Direction? = nil
    var indexSelectedMonthExp: String? = nil
    var indexSelectedYearExp: String? = nil
    @IBOutlet weak var confirmPayButton: UIButton!
    
    var sumProducts: Float {
        get {
            var sum:Float = 0.0
            for product in products {
                sum += (Float(product.price) ?? 0) * Float(product.number ?? 1)
            }
            return sum
        }
    }
    var shipCost: Float {
        get {
            if sumProducts < 1500 {
                return 110
            } else {
                return 0
            }
        }
    }
    var total: Float  {
        get {
            return sumProducts + shipCost
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setUpUIForDefaultView()
        title = "Confirmación de pago"
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateDirectionOptions()
    }
    
    func setUpUI() {
        totalProductsLabel.text = "$ " + String(format: "%.2f", sumProducts)
        shipCostLabel.textColor = UIColor.ShopApp.textImportant
        shipCostLabel.text =  shipCost == 0.0 ? "¡Gratis!" : "$ " + String(format: "%.2f", shipCost)
        totalLabel.text = "$ " + String(format: "%.2f", total)
        dropDownTextFields()
        
    }

    func dropDownTextFields() {
        directionTextField.optionArray = getDirections()
        directionTextField.didSelect { [weak self] (selectedText, index ,id) in
            guard let strongSelf = self else { return }
            strongSelf.selectedDirection = strongSelf.directionsArr[index]
        }
        monthExpTextField.optionArray = getMonths()
        yearExpTextField.optionArray = getYears()
    }
    
    func updateDirectionOptions() {
        directionTextField.selectedIndex = nil
        directionsArr = ShopCart.shared.directions
        directionTextField.optionArray = getDirections()
        directionTextField.text = ""
        selectedDirection = nil
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

    // TODO: Implement realm (get rows)
    func getDirections() -> [String] {
        var directions: [String] = [String]()
        for direction in ShopCart.shared.directions {
            directions.append(direction.alias)
        }
        return directions
    }
    
    func getMonths() -> [String] {
        var months: [String] = [String]()
        for i in 1...12 {
            let element = i < 10 ? "0\(i)" : String(i)
            months.append(element)
        }
        return months
    }
    
    func getYears() -> [String] {
        var years: [String] = [String]()
        var year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
        for _ in 1...7 {
            years.append(String(year))
            year += 1
        }
        return years
    }
    
    
    @IBAction func checkoutConfirmButtonAction(_ sender: UIButton) {
        if checkTextField(fields: [directionTextField, cvvCardTextField, creditCardTextField, yearExpTextField, monthExpTextField, cardHolderTextField]) && validationFields() && selectedDirection != nil {
            sender.isEnabled = false
            let identifier = UIDevice.identifier
            let data = ChargeData(products: ShopCart.shared.products, amount: total, creditCard: CreditCard(holder: cardHolderTextField.text!, number: creditCardTextField.text!, monthExpiration: monthExpTextField.text!, yearExpiration: yearExpTextField.text!), direction: selectedDirection!)
            KeysClient.shared.getKey(uidevice: identifier) { [weak self] (containerKey) in
                guard let strongSelf = self, var key = containerKey.key else {return}
                let cipherText = data.cipherJSON(key: key)
                self?.sendData(identifier: identifier, data: cipherText)
            }
            // block any action
        }
    }
    
    func sendData(identifier: String, data: String?) {
        let payload = ChargeRequest(uidevice: identifier, data: data ?? "")
        let loaderController = PaymentProccesViewController(nibName: "PaymentProccesViewController", bundle: nil)
        loaderController.charge = payload
        loaderController.delegate = self
        present(loaderController, animated: true)
    }
    
    func validationFields() -> Bool {
        var success = true
        
        if cvvCardTextField.text?.count != 3 {
            errorTextField(field: cvvCardTextField)
            success = false
        } else {
            cvvCardTextField.layer.borderWidth = 0.0
        }
        
        if creditCardTextField.text?.count != 16 {
            errorTextField(field: creditCardTextField)
            success = false
        } else {
            creditCardTextField.layer.borderWidth = 0.0
        }
        
        let currentYear = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
        let currenMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(NSCalendar.Unit.month, from: NSDate() as Date)
        if yearExpTextField.text == String(currentYear) && currenMonth > Int(monthExpTextField.text ?? "0") ?? 1 {
            errorTextField(field: monthExpTextField)
            success = false
        } else {
            monthExpTextField.layer.borderWidth = 0.0
        }

        return success
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

extension PayViewController: ActionAfterPayDelegate {
    func success(transaction: TransactionStored) {
        navigationController?.popViewController(animated: true)
        ShopCart.shared.products = []
        ShopCart.shared.purchased.append(transaction)
        ShopCart.shared.saveTransactionStorage()
        if let tabItems = tabBarController?.tabBar.items, let navigation = navigationController {
            let tabItem = tabItems[2]
            tabItem.badgeValue = nil
            navigation.popViewController(animated: true)
        }
    }
    
    func error() {
        creditCardTextField.text = ""
        cardHolderTextField.text = ""
        monthExpTextField.text = ""
        monthExpTextField.selectedIndex = nil
        yearExpTextField.text = ""
        yearExpTextField.selectedIndex = nil
        confirmPayButton.isEnabled = true
        //print("Hubo un error en el pago...")
    }
    
    
}
