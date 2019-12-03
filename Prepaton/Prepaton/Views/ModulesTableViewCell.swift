//
//  ModulesTableViewCell.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/15/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit

class ModulesTableViewCell: UITableViewCell {
    


    var materias = [Materia]()
    var lvc = LeccionesViewController(nibName: "LeccionesViewController", bundle: nil)
    var selectedCourse: Int = 0
    
    override func awakeFromNib() {
        
        self.materias = Materia().setInitialModules()
    }
    
    
}




