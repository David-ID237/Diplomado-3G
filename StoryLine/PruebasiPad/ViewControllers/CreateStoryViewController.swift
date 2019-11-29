//
//  EditStoryModalViewController.swift
//  Storyline
//
//  Created by Luis Mauricio Esparza Vazquez on 8/10/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import RealmSwift
import AVFoundation

class CreateStoryModalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var createStoryImageView: UIImageView!
    @IBOutlet weak var createStoryTextField: UITextField!
    var myStory = Story()
    
    var mainPageCollectionViewReference: MainPageCollectionViewController! //For code injection
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup Functions
    
    func setupView(){
        view.backgroundColor = .clear
        createStoryTextField.backgroundColor = .clear
        createStoryImageView.layer.cornerRadius = 10
    }
    
    // MARK: - Actions
    
    @IBAction func pressCreateButton(_ sender: Any) {
        myStory.image = myStory.compress(image: createStoryImageView.image!)
        myStory.storyName = createStoryTextField.text ?? "New Story"
        myStory.root = StoryNode()
        myStory.root?.chapter = Chapter()
        mainPageCollectionViewReference.stories.append(myStory)
        do {
            try realm.write {
                realm.add(myStory)
            }
        } catch {
            print("Error writing story to database")
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
    
    // MARK: - Delegate Functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        createStoryImageView.image = image
        dismiss(animated:true, completion: nil)
    }
    
}

