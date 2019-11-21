//
//  RemindersViewController.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 8/10/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import UIKit
import RealmSwift

class RemindersViewController: UIViewController {

    @IBOutlet weak var reminderTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var subjectTextField: DropDown!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubjectDropDownTextField()
        deadlineDatePicker.datePickerMode = .date
        deadlineDatePicker.setValue(UIColor.white, forKey: "textColor")
    }
    
    func setupSubjectDropDownTextField(){
        var subjectsNames = [String]()
        let subjects = realm.objects(Subject.self)
        for subject in subjects{
            subjectsNames.append(subject.name)
        }
        subjectTextField.optionArray = subjectsNames
    }
    
    func getReminderSubject(subjectName: String)->Subject{
        let subjects = realm.objects(Subject.self).filter("name == '\(subjectName)'")
        return subjects[0]
    }
    
    func showSuccessAlert(){
        let alert = UIAlertController(title: "", message: "Recordatorio agregado", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            _ = self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func selectRemiderType(_ sender: Any) {
        switch reminderTypeSegmentedControl.selectedSegmentIndex{
        case 0:
            descriptionLabel.text = "Actividad"
            descriptionTextField.placeholder = "Ingresa actividad de la tarea"
            descriptionTextField.text = ""
        case 1:
            descriptionLabel.text = "Temas del examen"
            descriptionTextField.placeholder = "Ingresa temas de examen separados por coma"
            descriptionTextField.text = ""
        case 2:
            descriptionLabel.text = "Titulo del proyecto"
            descriptionTextField.placeholder = ""
            descriptionTextField.text = ""
        default:
            break
        }
    }
    
    @IBAction func addReminder(_ sender: Any) {
        switch reminderTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            if(subjectTextField.text != "" && descriptionTextField.text != ""){
                let homework = Homework()
                let reminderSubject = getReminderSubject(subjectName: subjectTextField.text!)
                homework.subjectName = reminderSubject.name
                homework.activity = descriptionTextField.text!
                homework.deadline = deadlineDatePicker.date
                try! realm.write {
                    realm.add(homework)
                }
                showSuccessAlert()
            }else{
                let alert = UIAlertController(title: nil, message: "Tarea invalida", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        case 1:
            if(subjectTextField.text != "" && descriptionTextField.text != ""){
                let exam = Exam()
                let reminderSubject = getReminderSubject(subjectName: subjectTextField.text!)
                exam.subjectName = reminderSubject.name
                exam.topics = descriptionTextField.text!
                exam.date = deadlineDatePicker.date
                try! realm.write {
                    realm.add(exam)
                }
                showSuccessAlert()
            }else{
                let alert = UIAlertController(title: nil, message: "Examen invalido", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        case 2:
            if(subjectTextField.text != "" && descriptionTextField.text != ""){
                let project = Project()
                let reminderSubject = getReminderSubject(subjectName: subjectTextField.text!)
                project.subjectName = reminderSubject.name
                project.title = descriptionTextField.text!
                project.deadline = deadlineDatePicker.date
                try! realm.write {
                    realm.add(project)
                }
                showSuccessAlert()
            }else{
                let alert = UIAlertController(title: nil, message: "Proyecto invalido", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
}
