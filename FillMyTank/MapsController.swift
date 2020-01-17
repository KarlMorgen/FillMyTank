//
//  MapsController.swift
//  FillMyTank
//
//  Created by marouenabdi on 17/01/2020.
//  Copyright © 2020 MarouenAbdi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol MapsControllerDelegate : class {
    
    func mapsViewControllerDidSelectAnnotation(mapItem :MKMapItem)
}

class MapsController : UIViewController {
    
    @IBOutlet weak var maps: MKMapView!
    weak var delegate :MapsControllerDelegate!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    
        
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            maps.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices(){
        
        if CLLocationManager.locationServicesEnabled(){
            //setup the location manager.
            setupLocationManager()
            checkLocationAuthorization()
        }
        else{
            //Show alert let the user know how to do it.
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            maps.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        let annotationView = views.first!
        
        if let annotation = annotationView.annotation {
            if annotation is MKUserLocation {

                var region = MKCoordinateRegion()
                region.center = self.maps.userLocation.coordinate
                region.span.latitudeDelta = 0.025
                region.span.longitudeDelta = 0.025
                
                self.maps.setRegion(region, animated: true)
                
                populateNearByPlaces()

            }
        }
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let annotation = view.annotation as! PlaceAnnotation
        self.delegate.mapsViewControllerDidSelectAnnotation(mapItem: annotation.mapItem)
    }
    
    func populateNearByPlaces(){
        
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: self.maps.userLocation.coordinate.latitude, longitude: self.maps.userLocation.coordinate.longitude)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Gas Stations"
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard let response = response else {
                return
            }
            
            for item in response.mapItems {
                
                print(item.placemark)
                
                let annotation = PlaceAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                annotation.mapItem = item
                
                DispatchQueue.main.async {
                    self.maps.addAnnotation(annotation)
                }
                
                
            }
            
        }
    }
    
}

extension MapsController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        maps.setRegion(region, animated: true)
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
}
}
