//
//  CarTableViewCell.swift
//  shopapp
//
//  Created by David on 8/4/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    weak var cellActionDelegate: CellActionDelegate?
    
    var cellIndex: Int = 0 {
        didSet {
            uploadView()
        }
    }
    var product: Product?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func uploadView() {
        guard let product = self.product else { return }
        quantityStepper.tintColor = UIColor.ShopApp.yellow
        setStepper()
        nameTextView.text = product.name
        thumbnailImageView.getImageFromUrl(url: Config.host.value! + "/" + product.thumbnailUrl, contentModeFinal: .scaleAspectFit)
    }
    
    func setStepper() {
        guard let product = self.product else { return }
        amountLabel.text = "$ " + String(Float(product.number ?? 1) * (Float(product.price) ?? 0.0))
        quantityLabel.text = "Cantidad: " + String(product.number ?? 1)
    }
    
    @IBAction func quantityStepperAction(_ sender: UIStepper) {
        guard var product = self.product else { return }
        var numberP = product.number ?? 1
        if quantityStepper.value > 0 {
            product.number = Int(quantityStepper.value)
            self.product = product
            self.cellActionDelegate?.updateProduct(index: cellIndex, product: product)
            setStepper()
        } else {
            
            let alertDelete = UIAlertController(title: "¡Eliminar artículo!", message: "¿Realmente deseas eliminar este artículo?", preferredStyle: .alert)
            
            alertDelete.addAction(UIAlertAction(title: "Aceptar", style: .destructive, handler: { [weak self](alertAction) in
                guard let strongSelf = self else { return }
                strongSelf.cellActionDelegate?.deleteCell(cellId: strongSelf.cellIndex)
                alertDelete.dismiss(animated: true, completion: nil)
            }))
            
            alertDelete.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { [weak self](alertAction) in
                guard let strongSelf = self else { return }
                alertDelete.dismiss(animated: true, completion: nil)
                product.number = Int(1.0)
                strongSelf.product = product
                strongSelf.cellActionDelegate?.updateProduct(index: strongSelf.cellIndex, product: product)
                strongSelf.quantityStepper.value = 1.0
                strongSelf.setStepper()
            }))
            
            cellActionDelegate?.presentView(view: alertDelete)
            
        }
        
    }
    
}
