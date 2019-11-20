//
//  ReporteAsistenciaTableViewCell.swift
//  GroupAdmin

//  Copyright © 2019 Patricia Del Valle. All rights reserved.
//

import UIKit

class ReporteAsistenciaTableViewCell: UITableViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var cuenta: UILabel!
    @IBOutlet weak var labelNombreCell: UILabel!
    @IBOutlet weak var labelFaltasCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
