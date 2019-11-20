//
//  EmployeeTableViewCell.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/12/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var employeeImageView: UIImageView!
    
    @IBOutlet weak var empNameLbl: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
            employeeImageView.layer.cornerRadius = employeeImageView.bounds.size.width / 2.0
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
