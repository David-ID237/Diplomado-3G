//
//  CategoryTableViewCell.swift
//  shopapp
//
//  Created by David on 7/20/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameCategoryLabel: UILabel!
    var name: String?
    var url: String?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    func uploadView() {
        if let name = self.name, let url = self.url {
            nameCategoryLabel.text = name
            thumbnailImageView.getImageFromUrl(url: url, contentModeFinal: .scaleAspectFill)
        }
    }
        
}
