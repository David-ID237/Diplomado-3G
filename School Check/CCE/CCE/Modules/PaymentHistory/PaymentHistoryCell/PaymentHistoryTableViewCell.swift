//
//  PaymentHistoryTableViewCell.swift
//  CCE
//
//  Created by Carlos Ramirez on 7/28/19.
//  Copyright © 2019 Carlos Ramirez. All rights reserved.
//

import UIKit

class PaymentHistoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var lblRecieved: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
