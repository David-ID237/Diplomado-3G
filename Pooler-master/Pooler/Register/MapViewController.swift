//
//  MapViewController.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/9/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import MapKit
import UIKit

protocol setAddressDelegate {
    func returnAddres(coordinate:CLLocationCoordinate2D,address:MKLocalSearchCompletion)
}

class MapViewController: UIViewController,UINavigationControllerDelegate,UITableViewDelegate{
    
    var delegate:setAddressDelegate?
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    private var completion = MKLocalSearchCompletion()
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var setAddressBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCompleter.delegate = self
        mapView.delegate = self
        searchResultsTableView.isHidden = true
        setAddressBtn.isEnabled = false
        setAddressBtn.backgroundColor = .lightGray
        searchBar.placeholder = "Ingresa la dirección aquí"
        setupMapView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if let annotations = mapView?.annotations {
            mapView.removeAnnotations(annotations)
        }
        self.setAddressBtn.isEnabled = false
    }
    
    
    @IBAction func setAddress(_ sender: Any) {
        delegate?.returnAddres(coordinate: currentCoordinate!,address:completion)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    func setupMapView()  {
         if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
            let beginLocation = CLLocation(latitude: 19.4326077, longitude: -99.133208)
            let regionRadius:CLLocationDistance = 15000.0
            let region = MKCoordinateRegion(center: beginLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(region, animated: true)
        }
    }
}

extension MapViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else { return }
        currentCoordinate = currentLocation .coordinate
       
    }
    
}

extension MapViewController:MKMapViewDelegate{
   
}

extension MapViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchResultsTableView.isHidden = false
        self.setAddressBtn.isEnabled = false
        self.setAddressBtn.backgroundColor = .lightGray
        DispatchQueue.main.async { [weak self] in
            self!.searchCompleter.queryFragment = searchText
        }
    }
   
}

extension MapViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async { [weak self] in
            self!.searchResults = completer.results
        }
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension MapViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        completion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start {[weak self] (response, error) in
            if let error = error {
                print("Error getting locations: "+error.localizedDescription)
                return
            }
            
            self?.cleanMapView()

            self?.currentCoordinate = response?.mapItems[0].placemark.coordinate
    
            let annotation = MKPointAnnotation()
            annotation.coordinate = self!.currentCoordinate!
            annotation.title = self?.completion.title
            self?.mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: self!.currentCoordinate!,span: span)
            
            self?.mapView.setRegion(region, animated: true)
            
        }
        
    }
    
    func cleanMapView()  {
        view.endEditing(true)
        searchBar.text = ""
        searchResults.removeAll()
        searchResultsTableView.reloadData()
        searchResultsTableView.isHidden = true
        setAddressBtn.isEnabled = true
        setAddressBtn.backgroundColor = UIColor.ocean()
        
        if let annotations = mapView?.annotations {
            mapView.removeAnnotations(annotations)
        }
    }
}





