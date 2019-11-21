//
//  ClassnotesGalleryViewController.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 8/11/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import UIKit
import RealmSwift

class ClassnotesGalleryViewController: UIViewController {
    var selectedSubjectName = String()
    @IBOutlet weak var subjectNamesLabel: UILabel!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    var selectedImageData = String()
    let realm = try! Realm()
    var classNotes = [Classnote]()
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectNamesLabel.text = selectedSubjectName
        classNotes = getClassnotes(subjectName: selectedSubjectName)
        galleryCollectionView.backgroundColor = .clear
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func getClassnotes(subjectName: String) -> [Classnote]{
        var classNotes = [Classnote]()
        let classnotes = realm.objects(Classnote.self)
        for classnote in classnotes{
            if classnote.subjectName == subjectName{
                classNotes.append(classnote)
            }
        }
        return classNotes
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageSegue"{
            let classnoteImageViewController = segue.destination as! ClassnoteImageViewController
            classnoteImageViewController.imageData = self.selectedImageData
        }
    }
    
}

extension ClassnotesGalleryViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! GalleryCollectionViewCell
        cell.classnoteImageView.image = UIImage(data: Data(base64Encoded: classNotes[indexPath.row].imageData)!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImageData = classNotes[indexPath.row].imageData
        performSegue(withIdentifier: "imageSegue", sender: self)
    }
}
