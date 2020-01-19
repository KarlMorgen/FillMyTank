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

class MapsController : UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var maps: MKMapView!
    weak var delegate :MapsControllerDelegate!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    var region = MKCoordinateRegion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    
        
    }
    
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else {return}
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            maps.setRegion(region, animated: true)
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkLocationAuthorization()
        }
        
    }
    
    func setupLocationManager(){
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
            findStations()
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
                print("We have results!!!!!!!")
                print(response!.mapItems[0])
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
}
