//
//  ClassnotesViewController.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 8/4/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import UIKit
import RealmSwift

class ClassnotesViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var subjectsCollectionView: UICollectionView!
    var selectedSubjectName = ""
    let realm = try! Realm()
    var subjectsNames = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        subjectsCollectionView.delegate = self
        subjectsCollectionView.dataSource = self
        subjectsCollectionView.backgroundColor = .clear
        let results = realm.objects(Subject.self)
        for subject in results{
            subjectsNames.append(subject.name)
        }
    }
    
    func setupNavigationBar(){
        let imageButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takeClassnotePhoto))
        navigationItem.rightBarButtonItem = imageButton
    }
    
    @objc func takeClassnotePhoto(){
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.sourceType = .camera
        pickerController.delegate = self
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func getCurrentSubject(today: Date) -> Subject?{
        var selected : Subject?
        selected = nil
        let weekday = Calendar.current.component(.weekday, from: today)
        //Getting today's subjects
        var todaySubjects = [Subject]()
        let subjects = realm.objects(Subject.self)
        for subject in subjects{
            for d in subject.weekdays{
                if d.day == weekday{
                    todaySubjects.append(subject)
                }
            }
        }
        //Compare each subject start and endTime
        for subject in todaySubjects{
            if today.isBetween(startTime: subject.startTime, endTime: subject.endTime){
                selected = subject
            }
        }
        return selected
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gallerySegue"{
            let galleryViewController = segue.destination as! ClassnotesGalleryViewController
            galleryViewController.selectedSubjectName = selectedSubjectName
        }
    }
}

extension ClassnotesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjectsNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "classnotesCell", for: indexPath) as! ClassnotesCollectionViewCell
        cell.backgroundColor = .clear
        cell.subjectName.text = subjectsNames[indexPath.row]
        cell.subjectName.textColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(integerLiteral: 100)
        let height = CGFloat(integerLiteral: 100)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSubjectName = subjectsNames[indexPath.row]
        print(selectedSubjectName)
        performSegue(withIdentifier: "gallerySegue", sender: self)
    }
}

extension ClassnotesViewController : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        //Save classnote photo
        var isSaved = false
        let today = Date()
        let currentSubject = getCurrentSubject(today: today)
        if currentSubject == nil{
            let alertController = UIAlertController(title: nil, message: "No tienes ninguna clase en este horario", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else{
            isSaved = true
            print("Foto guardada: \(isSaved)")
            let classnote = Classnote()
            classnote.subject = currentSubject!
            classnote.subjectName = (currentSubject?.name)!
            selectedSubjectName = classnote.subject.name
            classnote.time = today
            guard let imageData = image.encodedBase64() else {return}
            classnote.imageData = imageData
            try! realm.write {
                realm.add(classnote)
            }
        }
        picker.dismiss(animated: true) {
            if isSaved{
                let alertController = UIAlertController(title: nil, message: "Foto guardada en \(self.selectedSubjectName)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: nil, message: "No tienes clases en este horario", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
