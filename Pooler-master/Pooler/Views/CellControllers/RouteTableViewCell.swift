//
//  RouteTableViewCell.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/11/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import Foundation
import UIKit

class RouteTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var seatsLbl: UILabel!
    @IBOutlet weak var daysLbl: UITextView!
    @IBOutlet weak var ownerProfileImage: UIImageView!
    @IBOutlet weak var ownerNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         ownerProfileImage.layer.cornerRadius = ownerProfileImage.bounds.size.width / 2.0
    }

}
