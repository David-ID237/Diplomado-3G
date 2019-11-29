//
//  ProjectCell.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/28/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var storyTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super .awakeFromNib()
        storyImageView.image = UIImage(named: "ivory paper")
        storyImageView.layer.cornerRadius = 10
        storyImageView.isUserInteractionEnabled = true
        storyTitleLabel.text = "New Story"
    }
}

/*Our custom Colection View Cell, it has an image view and a label so we can present the Story name and image (if there's any) on our app's main page. We also give it a Story so it can go around passing it whenever it goes from one view controller to the other. */
