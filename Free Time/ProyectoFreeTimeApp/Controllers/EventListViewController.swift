//
//  EventListViewController.swift
//  ProyectoFreeTimeApp
//
//  Created by Rodrigo Vivas y Noemí Rodríguez on 8/10/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class EventListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var eventListTableView: UITableView!
    
    var eventItem: Results<Task>? {
        get {
            guard let realm = LocalDatabaseManager.realm else { return nil }
            return realm.objects(Task.self)
        }
    }
    
    var event: EventsModel!
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("imagenes")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        eventListTableView.delegate = self
        eventListTableView.dataSource = self
        eventListTableView.rowHeight = 160
        eventListTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        eventListTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return DetailContainer.shared.showEvent().count
        return eventItem?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventListCell") as? EventListTableViewCell else { return UITableViewCell() }
        //Accedemos al elemento del carrito
        //let event = DetailContainer.shared.showEvent()[indexPath.row]
        
        let event = eventItem![indexPath.row]
        let downloadImageRef = imageReference.child(event.imageName)
        
        downloadImageRef.getData(maxSize: 1024*1024*12) { (data, error) in
            if error != nil{
                print("cargando")
            }
            else{
                cell.eventImage.image = UIImage(data: data!)
            }
        }
        cell.eventName.text = event.name
        cell.beginDate.text = event.beginDate
        cell.endDate.text = event.endDate
        cell.beginHour.text = event.endHour
        cell.endHour.text = event.endHour

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        event = DetailContainer.shared.showSaved()[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //DetailContainer.shared.removeEvent(position: indexPath.row)
            guard let realm = LocalDatabaseManager.realm else { return }
            
            do {
                try realm.write {
                    realm.delete(self.eventItem![indexPath.row])
                }
            }catch let error as NSError{
                print(error.localizedDescription)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            DetailContainer.shared.removeSaved(position: indexPath.row)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            guard let detailVC = segue.destination as? DetailViewController else { return }
            detailVC.event = event
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

