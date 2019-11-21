//
//  ReminderDetailViewController.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 8/12/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import UIKit
import RealmSwift

class ReminderDetailViewController: UIViewController {
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var homeworkTableView: UITableView!
    @IBOutlet weak var examTableView: UITableView!
    @IBOutlet weak var projectTableView: UITableView!
    
    var selectedHomeworks = [Homework]()
    var selectedExam = [Exam]()
    var selectedProject = [Project]()
    let formatter = DateFormatter()
    let realm = try! Realm()
    var selectedSubject = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedHomeworks = getHomework(selectedSubject: selectedSubject)
        selectedExam = getExam(selectedSubject: selectedSubject)
        selectedProject = getProject(selectedSubject: selectedSubject)
        homeworkTableView.delegate = self
        homeworkTableView.dataSource = self
        examTableView.delegate = self
        examTableView.dataSource = self
        projectTableView.delegate = self
        projectTableView.dataSource = self
        
        homeworkTableView.backgroundColor = .clear
        examTableView.backgroundColor = .clear
        projectTableView.backgroundColor = .clear
        
        formatter.dateFormat = "MM-dd-yyyy"
        subjectLabel.text = selectedSubject
    }
    
    func getHomework(selectedSubject: String) -> [Homework]{
        var hw = [Homework]()
        let homeworks = realm.objects(Homework.self).filter("subjectName == '\(selectedSubject)'")
        for homework in homeworks{
            hw.append(homework)
        }
        return hw
    }
    
    func getExam(selectedSubject: String) -> [Exam]{
        var e = [Exam]()
        let exams = realm.objects(Exam.self).filter("subjectName == '\(selectedSubject)'")
        for exam in exams{
            e.append(exam)
        }
        return e
    }
    
    func getProject(selectedSubject: String) -> [Project]{
        var p = [Project]()
        let projects = realm.objects(Project.self).filter("subjectName == '\(selectedSubject)'")
        for project in projects{
            p.append(project)
        }
        return p
    }
}

extension ReminderDetailViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int?
        if tableView == self.homeworkTableView{
            count = selectedHomeworks.count
        }
        if tableView == self.examTableView{
            count = selectedExam.count
        }
        if tableView == self.projectTableView{
            count = selectedProject.count
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        if tableView == homeworkTableView{
            let homeworkCell = tableView.dequeueReusableCell(withIdentifier: "homeworkCell", for: indexPath) as! HomeworkTableViewCell
            homeworkCell.backgroundColor = UIColor.clear
            homeworkCell.activityTextView.text = selectedHomeworks[indexPath.row].activity
            let date = formatter.string(from: selectedHomeworks[indexPath.row].deadline)
            homeworkCell.deadlineLabel.text = date
            homeworkCell.activityTextView.textColor = .white
            homeworkCell.deadlineLabel.textColor = .white
            return homeworkCell
            
        }
        if tableView == examTableView{
            let examCell = tableView.dequeueReusableCell(withIdentifier: "examCell", for: indexPath) as! ExamTableViewCell
            examCell.backgroundColor = UIColor.clear
            examCell.topicsTextView.text = selectedExam[indexPath.row].topics
            let date = formatter.string(from: selectedExam[indexPath.row].date)
            examCell.dateLabel.text = date
            examCell.topicsTextView.textColor = .white
            examCell.dateLabel.textColor = .white
            return examCell
        }
        if tableView == projectTableView{
            let projectCell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectTableViewCell
            projectCell.backgroundColor = UIColor.clear
            projectCell.titleTextView.text = selectedProject[indexPath.row].title
            let date = formatter.string(from: selectedProject[indexPath.row].deadline)
            projectCell.deadlineLabel.text = date
            projectCell.titleTextView.textColor = .white
            projectCell.deadlineLabel.textColor = .white
            return projectCell
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
}
