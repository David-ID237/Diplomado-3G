//
//  CollectionViewController.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/28/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit
import RealmSwift


class MainPageCollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var mainBackgroundImageView: UIImageView!
    private let reusableIdentifier = "ProjectCollectionViewCell"
    let backgroundImageName = "background 2"
    let createSegueIdentifier = "createStory"
    let openStorySegueId = "loadStory"
    let editStorySegueId = "editStory"
    let defaultSize = CGSize(width: 320, height: 510)
    
    var stories: List<Story> = List<Story>()
    var selectedStoryUUID: String = ""
    
    var editionIsOn: Bool = false
    var deletionIsOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        print("\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        setupCreateButton()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
        loadStories()
        self.collectionView.reloadData()
    }
    
    //MARK: - Setup Functions
    
    func setupView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        mainBackgroundImageView.image = UIImage(named: backgroundImageName)
        mainBackgroundImageView.alpha = 0.8
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Library"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "background 1"), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        editionIsOn = false
        deletionIsOn = false
        deleteButton.image = UIImage(named: "trash")
        editButton.image = UIImage(named: "pencil")
    }
    
    func setupCreateButton(){
        let createButton = UIButton()
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(.black, for: .normal)
        createButton.setBackgroundImage(UIImage(named: "blue node"), for: .normal)
        createButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        createButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        createButton.layer.shadowRadius = 0.0
        createButton.layer.shadowOpacity = 1.0
        createButton.layer.cornerRadius = 8
        createButton.layer.masksToBounds = false
        createButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        createButton.addTarget(self, action: #selector(MainPageCollectionViewController.createProjectPressed),for: .touchUpInside)
        self.view.addSubview(createButton)
        createButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        createButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    // MARK: - Utility Functions
    
    func deleteAlert(indexPath: Int){
        let alertController = UIAlertController(title: "Delete Story?", message: "Are you sure?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Keep story", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Delete story", style: .destructive, handler: { (action) in
            do {
                let realm = try Realm()
                let result = realm.objects(Story.self).filter(NSPredicate(format: "uuid CONTAINS %@", self.selectedStoryUUID))
                let storyToDelete = realm.objects(Story.self).filter(NSPredicate(format: "uuid CONTAINS %@", self.selectedStoryUUID)).first
                storyToDelete?.deleteRecords()
                try realm.write {
                    realm.delete(result)
                }
                self.stories.remove(at: indexPath)
                self.collectionView.reloadData()
            } catch {
                print("Error locating story to delete")
                return
            }
        }))
        self.present(alertController, animated: true, completion: nil)
        self.switchDeletion()
    }
    
    func loadStories() {
        do {
            let realm = try Realm()
            let results = realm.objects(Story.self)
            let temp = List<Story>()
            if results.count == 0 {
                return
            }
            for index in 0 ... (results.count - 1){
                temp.append(results[index])
            }
            self.stories = temp
        } catch {
            print("Valio verga leeyendo historias")
        }
    }
    
    func switchEdition(){
        editionIsOn = !editionIsOn
        if editionIsOn {
            navigationItem.title = "Select the story to edit"
            deleteButton.image = UIImage()
        } else {
            navigationItem.title = "Library"
            deleteButton.image = UIImage(named: "trash")
        }
    }
    
    func switchDeletion(){
        deletionIsOn = !deletionIsOn
        if deletionIsOn {
            navigationItem.title = "Select the story to delete"
            editButton.image = UIImage()
        } else {
            navigationItem.title = "Library"
            editButton.image = UIImage(named: "pencil")
        }
    }
    
    // MARK: - Actions
    
    @IBAction  func createProjectPressed(sender: UIButton){
        performSegue(withIdentifier: createSegueIdentifier, sender: self)
    }
    
    @IBAction func deleteStoryButtonPressed(_ sender: Any) {
        switchDeletion()
    }
    
    @IBAction func editStoryButtonPressed(_ sender: Any) {
        switchEdition()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case openStorySegueId:
            let gameView = segue.destination as? GameViewController
            gameView?.selectedStoryId = selectedStoryUUID
            
        case createSegueIdentifier:
            let createView = segue.destination as? CreateStoryModalViewController
            createView?.mainPageCollectionViewReference = self //Code injection
        
        case editStorySegueId:
            let editView = segue.destination as? EditStoryModalViewController
            editView?.mainPageCollectionViewReference = self //code injection
        default:
            print("¡Oh, Neptuno!")
        }
    }
}



extension MainPageCollectionViewController:  UICollectionViewDelegateFlowLayout {
    
    //MARK: - Class Functions
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return defaultSize
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! ProjectCollectionViewCell
        cell.storyTitleLabel.text = stories[indexPath.row].storyName
        cell.storyImageView.image = UIImage(data: stories[indexPath.row].image!)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedStoryUUID = stories[indexPath.row].uuid
        switch true {
        case deletionIsOn:
            deleteAlert(indexPath: indexPath.row)
            self.collectionView.reloadData()
            return
        case editionIsOn:
            performSegue(withIdentifier: editStorySegueId, sender: self)
            return
        default:
            self.performSegue(withIdentifier: openStorySegueId, sender: self)
        }
    }
}
