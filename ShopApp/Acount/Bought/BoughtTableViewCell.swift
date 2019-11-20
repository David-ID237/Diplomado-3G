//
//  BoughtTableViewCell.swift
//  shopapp
//
//  Created by David on 8/6/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class BoughtTableViewCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var aliasDirectionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var idTransactionLabel: UILabel!
    var transaction: TransactionStored? {
        didSet {
            updateView()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateView() {
        guard let transaction = self.transaction else {return}
        statusLabel.text = "Estado: \(transaction.transaction.status)"
        idTransactionLabel.text = "Id: \(transaction.transaction.identificator)"
        dateLabel.text = "Fecha: \(formatDate(transaction.transaction.createdAt ?? ""))"
        amountLabel.text = "Total: $ \(String(format: "%.2f", transaction.data.amount))"
        aliasDirectionLabel.text = "Dirección: \(transaction.data.directionAlias)"
    }
    
    func formatDate(_ dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        dateFormatterPrint.locale = NSLocale(localeIdentifier: "es_Es") as Locale
        
        let date = dateFormatterGet.date(from: dateString)
        guard let dateF = date else { return "" }
        return dateFormatterPrint.string(from: dateF)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
