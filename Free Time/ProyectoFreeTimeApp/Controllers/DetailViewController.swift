//
//  DetailViewController.swift
//  ProyectoFreeTimeApp
//
//  Created by Rodrigo Vivas y Noemí Rodríguez D3 on 8/2/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate, UINavigationBarDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var beginDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var beginHourLabel: UILabel!
    @IBOutlet weak var endHourLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var viewInScroll: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var map: MKMapView!
    var event: EventsModel!
    var imageReference: StorageReference {
        return Storage.storage().reference().child("imagenes")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navBar.delegate = self
        
        scrollView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 300, right: 0)
        
        
        let downloadImageRef = imageReference.child(event.imageName)
        
        downloadImageRef.getData(maxSize: 1024*1024*12) { (data, error) in
            if error != nil{
                print("cargando")
            }
            else{
                self.eventImage.image = UIImage(data: data!)
            }
        }
        
        nameLabel.text = event.name
        beginDateLabel.text = event.beginDate
        endDateLabel.text = event.endDate
        beginHourLabel.text = event.beginHour
        endHourLabel.text = event.endHour
        categoryLabel.text = event.category
        priceLabel.text = "$\(event.price)"
        addressLabel.text = event.address
        
        var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
        coordinate.latitude = event.latitud
        coordinate.longitude = event.longitud
        
        let annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = event.address
        map.addAnnotation(annotation)
        
        
        viewInScroll.addSubview(map)
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
    }
    
    
    
    @objc func showEvent(){
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let eventsVC = mainStoryboard.instantiateViewController(withIdentifier: "eventsVC")
        let nv = UINavigationController(rootViewController: eventsVC)
        present(nv, animated: true, completion: nil)
        
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        let buttonActionSheet = UIAlertController(title: "Free Time App", message: "¿Quieres agregar a la lista este evento?", preferredStyle: .actionSheet)
        
        
        buttonActionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        
        buttonActionSheet.addAction(UIAlertAction(title: "Agregar", style: .default, handler: { (action) in
            DetailContainer.shared.addToSave(item: self.event)
            
            
            guard let realm = LocalDatabaseManager.realm else{ return }
            let nextTaskId = (realm.objects(Task.self).max(ofProperty: "id") as Int? ?? 0) + 1
            let newTask = Task()
            newTask.id = nextTaskId
            newTask.name = self.event.name
            newTask.beginDate = self.event.beginDate
            newTask.endDate = self.event.endDate
            newTask.beginHour = self.event.beginHour
            newTask.endHour = self.event.endHour
            newTask.imageName = self.event.imageName
            newTask.category = self.event.category
            newTask.price = self.event.price
            newTask.address = self.event.address
            newTask.place = self.event.place
            
            do{
                try realm.write {
                    realm.add(newTask)
                }
            }catch let error as NSError{
                print(error.localizedDescription)
            }
            
            
            let message = UIAlertController(title: "Agregado", message: "¡El evento fue agregado a tu lista!", preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            message.addAction(acceptAction)
            self.present(message, animated: true, completion: nil)
        }))
        present(buttonActionSheet, animated: true, completion: nil)
    }
    
}
