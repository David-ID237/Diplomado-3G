//
//  AddClassViewController.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 7/23/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import UIKit
import RealmSwift

class AddSubjectViewController: UIViewController {
    @IBOutlet weak var subjectNameTextField: UITextField!
    @IBOutlet weak var subjectStartTimePicker: UIDatePicker!
    @IBOutlet weak var subjectEndTimePicker: UIDatePicker!
    @IBOutlet weak var classroomTextField: UITextField!
    @IBOutlet weak var teacherNameTextField: UITextField!
    @IBOutlet weak var weekdaysCollectionView: UICollectionView!
    let weekdays = ["D","L", "Ma", "Mi", "J", "V", "S"]
    var selectedWeekdayIndex = [Int]()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectStartTimePicker.datePickerMode = .time
        subjectEndTimePicker.datePickerMode = .time
        weekdaysCollectionView.delegate = self
        weekdaysCollectionView.dataSource = self
        subjectStartTimePicker.setValue(UIColor.white, forKey: "textColor")
        subjectEndTimePicker.setValue(UIColor.white, forKey: "textColor")
        weekdaysCollectionView.backgroundColor = UIColor.clear
    }
    
    //Adjust weekdays' index to get te correct day on the Calendar and correct data type to store using Realm
    func adjustIndex(array: [Int]) -> [Weekday]{
        var adjustIndex = [Weekday]()
        for element in array{
            let weekday = Weekday()
            weekday.day = element + 1
            adjustIndex.append(weekday)
        }
        return adjustIndex
    }
    
    @IBAction func saveSubject(_ sender: UIButton) {
        let selectedWeekdays = adjustIndex(array: selectedWeekdayIndex)
        if subjectNameTextField.text != "" && classroomTextField.text != "" && teacherNameTextField.text != "" && subjectEndTimePicker.date > subjectStartTimePicker.date{
            let subject = Subject()
            subject.name = subjectNameTextField.text!
            subject.classroom = classroomTextField.text!
            subject.teacher = teacherNameTextField.text!
            subject.startTime = subjectStartTimePicker.date
            subject.endTime = subjectEndTimePicker.date
            subject.weekdays.removeAll()
            subject.weekdays.append(objectsIn: selectedWeekdays)
            try! realm.write {
                realm.add(subject)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }

}

extension AddSubjectViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekdays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekdayCell", for: indexPath) as! WeekdayCollectionViewCell
        if selectedWeekdayIndex.contains(indexPath.row){
            cell.weekdayLabel.backgroundColor = UIColor.red
            cell.weekdayLabel.textColor = UIColor.white
        }else{
            cell.weekdayLabel.backgroundColor = UIColor.clear
            cell.weekdayLabel.textColor = UIColor.white
        }
        cell.layoutSubviews()
        cell.weekdayLabel.text = weekdays[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedWeekdayIndex.contains(indexPath.row){
            selectedWeekdayIndex = selectedWeekdayIndex.filter {$0 != indexPath.row}
        }else{
            selectedWeekdayIndex.append(indexPath.row)
        }
        collectionView.reloadData()
    }
}

