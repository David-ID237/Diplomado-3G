//
//  RouteDetailViewController.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/14/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import UIKit
import MapKit
import Firebase

protocol setSeats {
    func updateSeats()
}

class RouteDetailViewController: UIViewController {
    
    var route :Route?
    var enterprise = Enterprise()
    var employee = Employee()
    let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    var beginLocation:CLLocation?
    var endLocation:CLLocation?
    var steps = [MKRoute.Step]()
    let ref = Database.database().reference (withPath: "routes")
    var delegate:setSeats?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var daysTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        setupRouteSpec()
        setupMapView()
        self.navigationItem.title = "Detalle"
        let defaults = UserDefaults.standard
        employee.UID = defaults.string(forKey: "employeeUID")
    }
    
    @IBAction func joinToRoute(_ sender: Any) {
        let alert = UIAlertController(title: "Unirse", message: "¿Deseas unirte a esta ruta?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Si", style: .default, handler: {[weak self] (action) in
            self!.ref.child((self!.route?.UID!)!).child("poolers").setValue(["user":  self!.employee.UID!])
            self?.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler:{[weak self] (action) in
            self!.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true)
        
        
    }
    
    
    
    
    func setupRouteSpec()  {
        
        let latitudeInitPoint = route!.address?.latitude?.toDouble()
        let longitudeInitPoint = route!.address?.longitude?.toDouble()
        let latitudeEndPoint = enterprise.location?.latitude?.toDouble()
        let longitudeEndPoint = enterprise.location?.longitude?.toDouble()
        beginLocation = CLLocation(latitude:  latitudeInitPoint!, longitude: longitudeInitPoint!)
        endLocation = CLLocation(latitude: latitudeEndPoint!, longitude: longitudeEndPoint!)
        addressTextView.text = route!.address?.locationSubtitle
        timePicker.date = route!.getTodayDate(at: (hour: route!.departureTimeHour!, minute: route!.departureTimeMinutes!))
        feeLabel.text = String(describing: route!.price!)
        daysTextView.text = route!.days
        
    }
    
    func setupMapView()  {
        
        let sourcePin = customPin(pinTite: (route!.address?.locationTitle!)!, location: beginLocation!.coordinate)
        let destinationPin = customPin(pinTite: enterprise.location!.locationSubtitle!, location: endLocation!.coordinate)
        self.mapView.addAnnotation(sourcePin)
        self.mapView.addAnnotation(destinationPin)
        
        let sourcePlaceMark = MKPlacemark(coordinate: beginLocation!.coordinate)
        let destinationPlaceMarck = MKPlacemark(coordinate: endLocation!.coordinate)
        
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark )
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMarck)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResponse = response else {
                if let error = error{
                    print("Error to render route: "+error.localizedDescription)
                }
                return
            }
            let route = directionResponse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        self.mapView.delegate = self
        
    }
    
}


extension RouteDetailViewController: MKMapViewDelegate{

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.teal()
        renderer.lineWidth = 5
        return renderer
    }
    
}

class customPin: NSObject,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTite:String,location:CLLocationCoordinate2D) {
        self.title = pinTite
        self.coordinate = location
    }
}
