//
//  LessonsTableViewCell.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/28/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit
//Custom cell for displaying the lessons
class LessonsTableViewCell: UITableViewCell {

    @IBOutlet weak var lessonNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 15
    }
}

extension LessonsTableViewCell {
    //Sets the rating images for the cell according to the score
    func setStars(for score: Int) {
        if  score == 1000 {
            star1.image = UIImage(named: "star")
            star2.image = UIImage(named: "star")
            star3.image = UIImage(named: "star")
            star4.image = UIImage(named: "star")
            star5.image = UIImage(named: "star")
            return
        } else if score >= 800{
            star1.image = UIImage(named: "star")
            star2.image = UIImage(named: "star")
            star3.image = UIImage(named: "star")
            star4.image = UIImage(named: "star")
            star5.image = UIImage(named: "emptyStar")
            return
        } else if score >= 600{
            star1.image = UIImage(named: "star")
            star2.image = UIImage(named: "star")
            star3.image = UIImage(named: "star")
            star4.image = UIImage(named: "emptyStar")
            star5.image = UIImage(named: "emptyStar")
            return
        } else if score >= 400{
            star1.image = UIImage(named: "star")
            star2.image = UIImage(named: "star")
            star3.image = UIImage(named: "emptyStar")
            star4.image = UIImage(named: "emptyStar")
            star5.image = UIImage(named: "emptyStar")
            return
        } else if score >= 200{
            star1.image = UIImage(named: "star")
            star2.image = UIImage(named: "emptyStar")
            star3.image = UIImage(named: "emptyStar")
            star4.image = UIImage(named: "emptyStar")
            star5.image = UIImage(named: "emptyStar")
            return
        } else {
            star1.image = UIImage(named: "emptyStar")
            star2.image = UIImage(named: "emptyStar")
            star3.image = UIImage(named: "emptyStar")
            star4.image = UIImage(named: "emptyStar")
            star5.image = UIImage(named: "emptyStar")
            return
        }
    }
    //sets the background color for the cell according to the indexPath of the cell
    func setBackground (for sectionOrRow: Int){
        switch sectionOrRow{
        case 7:
            background.backgroundColor = UIColor(red: 0.48, green: 0.78, blue: 0.05, alpha: 1.0)
        case 8:
            background.backgroundColor = UIColor(red: 0.56, green: 0.88, blue: 0.00, alpha: 1.0)
        case 9:
            background.backgroundColor = UIColor(red: 0.98, green: 0.66, blue: 0.09, alpha: 1.0)
        case 0:
            background.backgroundColor = UIColor(red: 1.00, green: 0.78, blue: 0.08, alpha: 1.0)
        case 1:
            background.backgroundColor = UIColor(red: 0.83, green: 0.19, blue: 0.19, alpha: 1.0)
        case 2:
            background.backgroundColor = UIColor(red: 0.9, green: 0.22, blue: 0.22, alpha: 1.0)
        case 3:
            background.backgroundColor = UIColor(red: 0.11, green: 0.69, blue: 0.96, alpha: 1.0)
        case 4:
            background.backgroundColor = UIColor(red: 0.08, green: 0.83, blue: 0.96, alpha: 1.0)
        case 5:
            background.backgroundColor = UIColor(red: 0.52, green: 0.29, blue: 0.73, alpha: 1.0)
        case 6:
            background.backgroundColor = UIColor(red: 0.65, green: 0.38, blue: 0.91, alpha: 1.0)
        default:
            background.backgroundColor = .clear
        }
    }
}
