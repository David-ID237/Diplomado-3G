//
//  ViewController.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 7/22/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import UIKit
import RealmSwift

class SemesterConfigurationViewController: UIViewController {
    @IBOutlet weak var beginDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var semesterTitleTextField: UITextField!
    
    var beginDate = Date()
    var endDate = Date()
    var semester = Semester()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        beginDatePicker.setValue(UIColor.white, forKey: "textColor")
        endDatePicker.setValue(UIColor.white, forKey: "textColor")
    }

    @IBAction func nextButton(_ sender: Any) {
        if semesterTitleTextField.text != ""{
            semester.title = semesterTitleTextField.text!
            semester.beginDate = beginDatePicker.date
            semester.endDate = endDatePicker.date
            //Writting semester object on the database
            try! realm.write{
                realm.add(semester)
            }
            performSegue(withIdentifier: "configurationSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "configurationSegue"{
            let subjectsConfigurationViewController = segue.destination as! SubjectsConfigurationViewController
        }
    }
}

