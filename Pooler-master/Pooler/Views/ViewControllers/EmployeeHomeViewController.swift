//
//  EmployeeHomeViewController.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/11/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class EmployeeHomeViewController: UIViewController{
    
    @IBOutlet weak var routesTableView: UITableView!
    @IBOutlet weak var profileDetailView: ProfileDetail!
    
    var employee = Employee()
    var route = Route()
    var enterprise = Enterprise()
     var arrRoutesCount = 0
    let ref = Database.database().reference (withPath: "routes")
    var arrRoutes:[Route] = []{
        didSet{ self.routesTableView.reloadData() }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    
    func setupUI() {
        self.routesTableView.delegate = self
        self.routesTableView.dataSource = self
        self.navigationItem.title = "Rutas"
        
        let defaults = UserDefaults.standard
        defaults.set(employee.UID!, forKey: "employeeUID")
        defaults.set(employee.enterprise!, forKey: "enterpriseUID")
        defaults.set(employee.name,forKey: "employeeName")
        defaults.set(employee.profileImage,forKey: "employeeImage")
        profileDetailView.nameLabel.text = employee.name
//        DispatchQueue.main.async {
            self.getRoutes()
            self.getEnterpriseData()
//        }
        profileDetailView.profileImageView.image = employee.profileImage?.base64ToImage()
        
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getRoutes()  {
//        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
       
        self.ref.queryOrdered(byChild: "enterprise").queryEqual(toValue: enterprise.UID).observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let myChild = child as! DataSnapshot
                let key = myChild.key
                if let myChildValue = myChild.value as? [String:Any]{
//                    print(myChildValue)
//                    if myChildValue["enterprise"]! as? String == self.employee.enterprise! {
                        let tempRoute = Route()
                        tempRoute.enterprise = Enterprise()
                        tempRoute.enterprise!.location = Location()
                        tempRoute.address = Location()
                        tempRoute.employee = Employee()
                        tempRoute.UID = key
                        tempRoute.days = myChildValue["days"]! as? String
                        tempRoute.price = myChildValue["price"]! as? Int
                        tempRoute.employee?.name = myChildValue["ownerName"]! as? String
                        tempRoute.employee?.profileImage = myChildValue["ownerImage"]! as? String
                        tempRoute.address?.longitude = myChildValue["longitude"]! as? String
                        tempRoute.address?.latitude = myChildValue["latitude"]! as? String
                        tempRoute.address?.locationTitle = myChildValue["addressTitle"]! as? String
                        tempRoute.address?.locationSubtitle = myChildValue["addressSubtitle"]! as? String
                        tempRoute.poolers = (myChildValue["poolers"] as? [String:Any] ) ??  [String:Any]()
                        tempRoute.seats = (myChildValue["seats"]! as? Int)!
                        let poolersCount = tempRoute.poolers?.count ?? 0
                        if poolersCount>0 {
                            if poolersCount <= tempRoute.seats{
                                tempRoute.seats = tempRoute.seats - poolersCount
                            }
                        }
                        tempRoute.employee?.UID = myChildValue["employee"]! as? String
                        tempRoute.departureTimeHour = myChildValue["departureHour"]! as? Int
                        tempRoute.departureTimeMinutes = myChildValue["departureMinutes"]! as? Int
                        tempRoute.enterprise?.UID = myChildValue["enterprise"]! as? String
                        if tempRoute.seats > 0 {
                           self.arrRoutes.append(tempRoute)
                        }
                     
                        self.arrRoutesCount = self.arrRoutes.count
                        
//                    }
                }
            }
        })
        
    }
    
    @IBAction func addRoute(_ sender: Any) {
        if let newRouteVC = self.storyboard?.instantiateViewController(withIdentifier: "newRouteVC") as? NewRouteViewController {
            self.navigationController?.show(newRouteVC, sender: sender)
        }
    }
        
    
    
    func getEnterpriseData()  {
        Database.database().reference(withPath: "users").child((UserDefaults.standard.string(forKey: "enterpriseUID")!)).observeSingleEvent(of: .value) {[weak self](snap) in
            var tempLocation = Location()
            let value = snap.value as? NSDictionary
            tempLocation.longitude = value?["longitude"] as? String ?? ""
            tempLocation.latitude = value?["latitude"] as? String ?? ""
            tempLocation.locationSubtitle = value?["addressSubtitle"] as? String ?? ""
            tempLocation.locationTitle = value?["addressTitle"] as? String ?? ""
            self!.enterprise.location = tempLocation
        }
        
    }
    
}

extension EmployeeHomeViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRoutes.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell") as? RouteTableViewCell
            cell!.addressLbl!.text = arrRoutes[indexPath.row].address?.locationTitle!
            cell!.seatsLbl!.text = "\(String(describing: arrRoutes[indexPath.row].seats))"
            cell!.daysLbl.text = arrRoutes[indexPath.row].days
            cell?.priceLbl.text = "\(String(describing: arrRoutes[indexPath.row].price!))"
            cell!.ownerProfileImage.image = arrRoutes[indexPath.row].employee?.profileImage?.base64ToImage()
            cell!.ownerNameLbl.text = arrRoutes[indexPath.row].employee?.name
         return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let routeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailRouteVC" ) as? RouteDetailViewController {
            routeDetailVC.route = self.arrRoutes[indexPath.row]
            routeDetailVC.enterprise = self.enterprise
            self.navigationController?.pushViewController(routeDetailVC, animated: true)
            routeDetailVC.delegate = self
        }
    }
    
}

extension EmployeeHomeViewController: setSeats{
    func updateSeats() {
        self.getRoutes()
        self.routesTableView.reloadData()
        let alertController = UIAlertController(title: "Solicitud enviada", message: "Tu solicitud fue enviada al pooler de la ruta.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
}
