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

class MapsController : UIViewController {
    
    @IBOutlet weak var maps: MKMapView!
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
    
}

extension MapsController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Something here    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //something here
    }
    
}
}
