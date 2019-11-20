//
//  PaymentProccesViewController.swift
//  shopapp
//
//  Created by David on 8/11/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

protocol ActionAfterPayDelegate: class {
    func success(transaction: TransactionStored)
    func error()
}

class PaymentProccesViewController: UIViewController {

    var charge: ChargeRequest?
    weak var delegate: ActionAfterPayDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        sendData()
        // Do any additional setup after loading the view.
    }
    
    func sendData() {
        guard let charge = self.charge else { return }
        ChargeClient.shared.post(payload: charge) { [weak self] (response) in
            guard let strongSelf = self else {return}
            let title = response.success ? "¡Pago exitoso!" : "¡Ha ocurrido un error!"
            let message = response.success ? "¡Gracias por tu compra!\nEl estatus de tu pedido se actualizara en la seccion de compras realizadas en tu cuenta." : "Se presentó un problema al realizar el pago, intente de nuevo: \(response.message)."
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButtonAction = alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (alertaction) in

                strongSelf.dismiss(animated: true, completion: {
                    if(response.success) {
                        let newTransaction = TransactionStored(transaction: response.transaction!, data: response.charge!)
                        strongSelf.delegate?.success(transaction: newTransaction)
                    } else {
                        strongSelf.delegate?.error()
                    }
                    strongSelf.dismiss(animated: true, completion: nil)
                })
                
            }))
            
            strongSelf.present(alertController, animated: true)
        }
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
