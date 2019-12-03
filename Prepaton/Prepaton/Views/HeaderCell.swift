//
//  headerCell.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/18/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var unitNameLbl: UILabel!
    
    @IBOutlet weak var unitProgressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
