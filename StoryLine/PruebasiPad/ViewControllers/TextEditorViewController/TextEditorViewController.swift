//
//  DocumentViewController.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/30/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit
import RealmSwift

class TextEditorViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var chapterNameLabel: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    let realm = try! Realm()
    var changesBeforeAutosave: Int = 0
    var parentNodeUUID: String?
    var chapterUUID: String?
    var editionBool: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self //TextView delegate
        setupAdaptativeScroll()
    }
    
    // MARK: - Setup Functions
    
    func setupAdaptativeScroll(){
        //Setup scroll and adaptative keyboard scroll
        NotificationCenter.default.addObserver(self, selector: #selector(TextEditorViewController.updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TextEditorViewController.updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Override functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if editionBool! {
        let chapter = realm.objects(Chapter.self).filter(NSPredicate(format: "chapterUUID CONTAINS %@", chapterUUID!)).first
        chapterNameLabel.text = chapter?.chapterTitle
        textView.text = chapter?.contentsOfChapter
        }
        textView.backgroundColor = .clear
        textView.textColor = .black
        let font = UIFont(name: "Avenir Next", size: 25)
        textView.font = font
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //Hide Keyboard
        super.touchesBegan(touches, with: event)
        super.view.endEditing(true)
    }
    
    // MARK: - Helper functions
    
//    //Autosave changes after 100 changes.
//    func textViewDidChange(_ textView: UITextView) { //Does something everytime the text changes
//        changesBeforeAutosave += 1
//        if changesBeforeAutosave == 100 {
//            do {
//                let chapter = realm.objects(Chapter.self).filter(NSPredicate(format: "chapterUUID CONTAINS %@", chapterUUID!)).first
//                try realm.write {
//                    chapter!.chapterTitle = chapterNameLabel.text
//                    chapter!.contentsOfChapter = textView.text
//                }
//            } catch {
//                print("Unable to save changes")
//            }
//            changesBeforeAutosave = 0
//        }
//    }
    
    func saveChanges(){
        if editionBool! {
            do {
                let chapter = realm.objects(Chapter.self).filter(NSPredicate(format: "chapterUUID CONTAINS %@", chapterUUID!)).first
                try realm.write {
                    chapter!.chapterTitle = chapterNameLabel.text ?? " "
                    chapter!.contentsOfChapter = textView.text ?? " "
                }
            } catch {
                print("Unable to save changes")
            }
        } else {
            do {
                let parent = realm.objects(StoryNode.self).filter(NSPredicate(format: "stringUUID CONTAINS %@", parentNodeUUID!)).first //Reference to parent node we created for
                //We create everything
                let newNode = StoryNode()
                let newChapter = Chapter()
                try realm.write {
                    newChapter.chapterTitle = chapterNameLabel.text ?? " "
                    newChapter.contentsOfChapter = textView.text ?? " "
                    newNode.chapter = newChapter
                    parent?.childrenNodesUUID.append(newNode.stringUUID!)
                    realm.add(newNode)
                }
            } catch {
                print("Unable to write new chapter")
            }
        }
    }
    
    // MARK: - Obj-C Stuff
    
    //Get keyboard frame not to interfere with text in textView
    @objc func updateTextView(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardEndFrameScreenCoordinates = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = self.view.convert(keyboardEndFrameScreenCoordinates, to: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification
        {
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndFrame.height, right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    // MARK: - Actions
    
    @IBAction func dismissDocumentViewController() {
        saveChanges()
        dismiss(animated: true)
    }
}
