//
//  CellUsersTableViewCell.swift
//  CCE
//
//  Created by Carlos Ramirez on 12/9/18.
//  Copyright © 2018 Carlos Ramirez. All rights reserved.
//

import UIKit

class CellUsersTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var lblNameCell: UILabel!
    @IBOutlet weak var lblSubtitleCell: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
