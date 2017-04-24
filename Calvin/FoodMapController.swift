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

        self.map.addAnnotation(Restaurant(name: "Blaqk", latitude: 46.201858, longitude: 6.1540286))
        self.map.addAnnotation(Restaurant(name: "Street Gourmet", latitude: 46.202663, longitude: 6.150859))
        self.map.addAnnotation(Restaurant(name: "Maison du Sandwich", latitude: 46.2016319, longitude: 6.1522996))
        self.map.addAnnotation(Restaurant(name: "Maison du Sandwich", latitude: 46.2024709, longitude: 6.1547259))
        self.map.addAnnotation(Restaurant(name: "Maison du Sandwich", latitude: 46.2003257, longitude: 6.1496456))
        self.map.addAnnotation(Restaurant(name: "Just Bubble", latitude: 46.193981, longitude: 6.140108))
        
        let calvin = Calvin()
        self.map.addAnnotation(calvin)
        
        let region = MKCoordinateRegionMakeWithDistance(calvin.coordinate, 2000, 2000);
        
        self.map.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        return
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        return
    }
}
