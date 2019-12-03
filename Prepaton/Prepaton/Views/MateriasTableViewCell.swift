//
//  MateriasTableViewCell.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/28/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit
//Custom cell for displaying the courses
class MateriasTableViewCell: UITableViewCell {

    @IBOutlet weak var materiaImage: UIImageView!
    @IBOutlet weak var materiaLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.background.layer.cornerRadius = 25
    }
}

extension MateriasTableViewCell {
    //Sets the backgrond color of the cell according to the indexPath
    func setBackground (for sectionOrRow: Int){
        switch sectionOrRow{
        case 0:
            background.backgroundColor = UIColor(red: 0.48, green: 0.78, blue: 0.05, alpha: 1.0)
        case 1:
            background.backgroundColor = UIColor(red: 0.56, green: 0.88, blue: 0.00, alpha: 1.0)
        case 2:
            background.backgroundColor = UIColor(red: 0.98, green: 0.66, blue: 0.09, alpha: 1.0)
        case 3:
            background.backgroundColor = UIColor(red: 1.00, green: 0.78, blue: 0.08, alpha: 1.0)
        case 4:
            background.backgroundColor = UIColor(red: 0.83, green: 0.19, blue: 0.19, alpha: 1.0)
        case 5:
            background.backgroundColor = UIColor(red: 0.9, green: 0.22, blue: 0.22, alpha: 1.0)
        case 6:
            background.backgroundColor = UIColor(red: 0.11, green: 0.69, blue: 0.96, alpha: 1.0)
        case 7:
            background.backgroundColor = UIColor(red: 0.08, green: 0.83, blue: 0.96, alpha: 1.0)
        case 8:
            background.backgroundColor = UIColor(red: 0.52, green: 0.29, blue: 0.73, alpha: 1.0)
        case 9:
            background.backgroundColor = UIColor(red: 0.65, green: 0.38, blue: 0.91, alpha: 1.0)
        default:
            background.backgroundColor = .clear
        }
    }
}
