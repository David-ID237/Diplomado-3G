//
//  EventListTableViewCell.swift
//  ProyectoFreeTimeApp
//
//  Created by Rodrigo Vivas y Noemí Rodríguez on 8/10/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit

class EventListTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var beginDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var beginHour: UILabel!
    @IBOutlet weak var endHour: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
