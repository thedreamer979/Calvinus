//
//  FoodMapController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 12.04.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit
import MapKit

class FoodMapController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map.delegate = self
        self.locationManager.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            if #available(iOS 9.0, *) {
                locationManager.requestLocation()
            }
            
            locationManager.startUpdatingLocation()
        }
        
        self.map.setUserTrackingMode(.follow, animated: true)

        self.map.addAnnotation(Restaurant(name: "swag", latitude: 46.2, longitude: 6.15))
        
        let calvin = Calvin()
        self.map.addAnnotation(calvin)
        
        let region = MKCoordinateRegionMakeWithDistance(calvin.coordinate, 2000, 2000);
        
        self.map.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
