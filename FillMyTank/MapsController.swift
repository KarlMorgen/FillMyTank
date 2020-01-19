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

class MapsController : UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var maps: MKMapView!
    weak var delegate :MapsControllerDelegate!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 5000
    var region = MKCoordinateRegion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        locationManager.startUpdatingLocation()
        maps.showsUserLocation = true
        
        
    
        
    }
    
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else {return}
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            maps.setRegion(region, animated: true)
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            //checkLocationAuthorization()
        }
        
    }
    
    func setupLocationManager(){
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
             region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            maps.setRegion(region, animated: true)
            
        }
    }
    
    func checkLocationServices(){
        
        if CLLocationManager.locationServicesEnabled(){
            //setup the location manager.
            setupLocationManager()
            //checkLocationAuthorization()
        }
        else{
            //Show alert let the user know how to do it.
        }
    }
    
    func mapView(_ maps: MKMapView, didAdd views: [MKAnnotationView]){
        
        let annotationView = views.first
        if let annotation = annotationView?.annotation{
            if annotation is MKUserLocation{
                print("Im here")
                centerViewOnUserLocation()
                findStations()
            }
        }
        
        
    }
    
//    func checkLocationAuthorization(){
//        switch CLLocationManager.authorizationStatus(){
//        case .authorizedWhenInUse:
//            maps.showsUserLocation = true
////            centerViewOnUserLocation()
////            locationManager.startUpdatingLocation()
////            findStations()
//        case .denied:
//            break
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            break
//        case .authorizedAlways:
//            break
//        }
//    }
    
    func findStations(){
        
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Gas station"
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if response == nil {
                print("ERROR")
            }
            else{
                //print("We have results!!!!!!!")
                for item in response!.mapItems {
                
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
    
//    func mapView(maps : MKMapView, didSelect view : MKAnnotationView){
//
//        guard let annotation = view.annotation else {
//            return
//        }
//
//        let directionRequest = MKDirections.Request()
//        directionRequest.source = MKMapItem.forCurrentLocation()
//        directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate))
//        directionRequest.transportType = .automobile
//        let directions = MKDirections(request: directionRequest)
//
//        directions.calculate {
//            (response, error) -> Void in
//            guard let response = response else {
//                if let error = error {
//                    print("Error: \(error)")
//                }
//                return
//            }
//
//            if !response.routes.isEmpty {
//                let route = response.routes[0]
//                DispatchQueue.main.async { [weak self] in
//                    self?.maps.addOverlay(route.polyline)
//                }
//            }
//        }
//    }
}
