//
//  CalificacionesTableViewCell.swift
//  GroupAdmin

//  Copyright © 2019 Patricia Del Valle. All rights reserved.
//

import UIKit

class CalificacionesTableViewCell: UITableViewCell ,  UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var cuentaLabel: UILabel!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var promedioLabel: UILabel!
    var pickerData : [[String]] = [["0","1","2","3","4","5","6","7","8","9","10"] ,["0","1","2","3","4","5","6","7","8","9","10"],["0","1","2","3","4","5","6","7","8","9","10"]]
    
    var calificaciones : [Float] = [0,0,0]
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pickerView.delegate = self
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][ row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        calificaciones[component] = Float( row )
        var promedio : Float = 0
        for elemento in calificaciones {
            promedio = promedio + elemento
        }
        promedioLabel.text = String (promedio / Float(pickerData.count))
    }

}
