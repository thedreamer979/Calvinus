//
//  CalvinMapView.swift
//  Calvin
//
//  Created by Arion Zimmermann on 05.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit
import MapKit

class GoToCalvinController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.map.delegate = self
        self.locationManager.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()
        }
        
        self.map.setUserTrackingMode(.follow, animated: false)
        let annotation = Calvin()
        self.map.addAnnotation(annotation)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            let request = MKDirectionsRequest()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.map.userLocation.coordinate, addressDictionary: nil))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil))
            request.requestsAlternateRoutes = true
            request.transportType = .walking
            
            let directions = MKDirections(request: request)
            
            directions.calculate {
                (response, error) -> Void in
                
                guard let response = response else {
                    if let error = error {
                        print(error)
                        showError(controller: self, description: error.localizedDescription)
                    }
                    return
                }
                
                let route = response.routes[0]
                self.map.add((route.polyline))
                
                let rect = route.polyline.boundingMapRect
                self.map.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            }
        })
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = self.view.tintColor.withAlphaComponent(0.7)
        renderer.lineWidth = 8.0
        
        return renderer
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
