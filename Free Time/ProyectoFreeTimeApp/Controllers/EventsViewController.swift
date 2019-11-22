//
//  EventsViewController.swift
//  ProyectoFreeTimeApp
//
//  Created by Rodrigo Vivas y Noemí Rodríguez on 7/25/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit
import Firebase

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    var eventsRef: DatabaseReference!
    var event: EventsModel!
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("imagenes")
    }
    
    
    var eventsList = [EventsModel]()
    var imagesList = [UIImage]()
    var filterList = [EventsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 160
        navBar.delegate = self
        
        eventsRef = Database.database().reference().child("eventos")
        eventsRef.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0{
                self.eventsList.removeAll()
                for events in snapshot.children.allObjects as! [DataSnapshot]{
                    let eventObject = events.value as? [String:AnyObject]
                    
                    let event = EventsModel(name: eventObject?["Nombre"] as? String ?? "", beginDate: eventObject?["FechaInicio"] as? String ?? "", endDate: eventObject?["FechaFin"] as? String ?? "", beginHour: eventObject?["HoraInicio"] as? String ?? "", endHour: eventObject?["HoraFin"] as? String ?? "", imageName: "\(String(describing: eventObject?["Imagen"] as? String ?? "")).jpg", latitud: eventObject?["Latitud"] as? Double ?? 0.0, longitud: eventObject?["Longitud"] as? Double ?? 0.0, category: eventObject?["Categoria"] as? String ?? "", price: eventObject?["Precio"] as? Double ?? 0.00, address: eventObject?["Direccion"] as? String ?? "", place: eventObject?["Recinto"] as? String ?? "")
                    
                    self.eventsList.append(event)
                    DetailContainer.shared.addItem(item: event)
                    self.filterList.append(event)
                }
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventsTableViewCell
        let event: EventsModel
        event = filterList[indexPath.row]
        
        let downloadImageRef = imageReference.child(event.imageName)
        
        downloadImageRef.getData(maxSize: 1024*1024*12) { (data, error) in
            if error != nil{
                print("cargando")
            }
            else{
                cell.eventImage.image = UIImage(data: data!)
            }
        }
        /*
        downloadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "Terminó")
        }
        
        downloadTask.resume()*/
        
        cell.nameLabel.text = event.name
        cell.beginDate.text = event.beginDate
        cell.endDate.text = event.endDate
        cell.beginHour.text = event.beginHour
        cell.endHour.text = event.endHour
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        event = filterList[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func showFilter(_ sender: Any) {
        performSegue(withIdentifier: "filterSegue", sender: nil)
    }
    
    
    
    @IBAction func getFilterInformation(_ sender: UIStoryboardSegue){
        
        guard let filterVC = sender.source as? FilterViewController else { return }
        if filterVC.selectedPlace == "Todos"{
            if filterVC.radioButton1.isSelected{
                filterList.removeAll()
                for event in eventsList{
                    if event.category == filterVC.radioButton1.currentTitle{
                        filterList.append(event)
                        
                    }
                }
                tableView.reloadData()
            } else if filterVC.radioButton2.isSelected{
                filterList.removeAll()
                for event in eventsList{
                    if event.category == filterVC.radioButton2.currentTitle{
                        
                        filterList.append(event)
                        
                    }
                }
                tableView.reloadData()
                
            } else if filterVC.radioButton3.isSelected{
                filterList.removeAll()
                for event in eventsList{
                    if event.category == filterVC.radioButton3.currentTitle{
                        filterList.append(event)
                        tableView.reloadData()
                    }
                }
                tableView.reloadData()
            }
            else{
                filterList = eventsList
                tableView.reloadData()
            }
        }else{
            if filterVC.radioButton1.isSelected{
                filterList.removeAll()
                for event in eventsList{
                    if event.category == filterVC.radioButton1.currentTitle && event.place == filterVC.selectedPlace{
                        filterList.append(event)
                        
                    }
                }
                tableView.reloadData()
            } else if filterVC.radioButton2.isSelected{
                filterList.removeAll()
                for event in eventsList{
                    if event.category == filterVC.radioButton2.currentTitle  && event.place == filterVC.selectedPlace{
                        
                        filterList.append(event)
                        
                    }
                }
                tableView.reloadData()
                
            } else if filterVC.radioButton3.isSelected {
                filterList.removeAll()
                for event in eventsList{
                    if event.category == filterVC.radioButton3.currentTitle && event.place == filterVC.selectedPlace{
                        filterList.append(event)
                        tableView.reloadData()
                    }
                }
                tableView.reloadData()
            }
            else{
                filterList = eventsList
                tableView.reloadData()
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            guard let detailVC = segue.destination as? DetailViewController else { return }
            detailVC.event = event
        }
    }
    
}

