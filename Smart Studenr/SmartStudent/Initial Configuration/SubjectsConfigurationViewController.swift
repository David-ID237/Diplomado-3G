//
//  ClassesConfigurationViewController.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 7/23/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import UIKit
import RealmSwift

class SubjectsConfigurationViewController: UIViewController {
    @IBOutlet weak var subjectsTableView: UITableView!
    
    let realm = try! Realm()
    var subjects = [Subject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        subjectsTableView.delegate = self
        subjectsTableView.dataSource = self
        subjectsTableView.backgroundColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getSubjects()
        subjectsTableView.reloadData()
        
    }
    
    @IBAction func addClass(_ sender: UIButton) {
        if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "addSubjectViewController") as? AddSubjectViewController{
            let navigationController = UINavigationController(rootViewController: nextViewController)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func goToCalendar(_ sender: Any) {
        if let calendarViewController = self.storyboard?.instantiateViewController(withIdentifier: "calendarViewController") as? CalendarViewController{
            let navigationController = UINavigationController(rootViewController: calendarViewController)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    func getSubjects(){
        subjects = []
        let s = realm.objects(Subject.self)
        for subject in s{
            subjects.append(subject)
        }
    }
}

extension SubjectsConfigurationViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Date formatter to show start and end time correctly for each subject
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath) as! SubjectTableViewCell
        cell.subjectNameLabel.text = subjects[indexPath.row].name
        cell.subjectTimeLabel.text = "\(formatter.string(from: subjects[indexPath.row].startTime)) - \(formatter.string(from:  subjects[indexPath.row].endTime))"
        cell.subjectTeacherLabel.text = subjects[indexPath.row].teacher
        cell.subjectClassroomLabel.text = subjects[indexPath.row].classroom
        cell.backgroundColor = UIColor.clear
        cell.subjectNameLabel.textColor = UIColor.white
        cell.subjectTimeLabel.textColor = UIColor.white
        cell.subjectTeacherLabel.textColor = UIColor.white
        cell.subjectClassroomLabel.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(140)
    }
}
