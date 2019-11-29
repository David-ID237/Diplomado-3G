//
//  CreateStoryModalViewController.swift
//  Storyline
//
//  Created by Luis Mauricio Esparza Vazquez on 8/4/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import RealmSwift
import AVFoundation

class EditStoryModalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var editStoryImageView: UIImageView!
    @IBOutlet weak var editStoryTextField: UITextField!
    
    var mainPageCollectionViewReference: MainPageCollectionViewController! //For code injection
    let realm = try! Realm()
    var storyToEdit: Story?

    override func viewDidLoad() {
        super.viewDidLoad()
        storyToEdit = realm.objects(Story.self).filter(NSPredicate(format: "uuid CONTAINS %@", mainPageCollectionViewReference.selectedStoryUUID)).first
        setupView()
    }
    
    
    // MARK: - Setup Functions

    func setupView(){
        do {
            self.editStoryTextField.text = storyToEdit?.storyName
            self.editStoryImageView.image = storyToEdit?.buildImageFrom(data: storyToEdit!.image!)
        }
        view.backgroundColor = .clear
        editStoryTextField.backgroundColor = .clear
        editStoryImageView.layer.cornerRadius = 10
    }
    
    // MARK: - Actions
    
    @IBAction func saveChangesPressed(_ sender: Any) {
        do {
            try realm.write {
                storyToEdit?.storyName = editStoryTextField.text ?? "Edited Story"
                storyToEdit?.image = storyToEdit?.compress(image: editStoryImageView.image!)
            }
        } catch {
            print("Couldn't edit the Story")
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func switchImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - UINavigationControllerDelegate Functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        editStoryImageView.image = image
        dismiss(animated:true, completion: nil)
    }

}

/*This view controller has to get the user info for an existing story, its image and name.
 */
