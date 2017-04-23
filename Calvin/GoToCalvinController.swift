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
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            if #available(iOS 9.0, *) {
                locationManager.requestLocation()
            }
            
            locationManager.startUpdatingLocation()
        }
        
        self.map.setUserTrackingMode(.follow, animated: true)
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
                
                if let response = response {
                    for route in response.routes {
                        self.map.add((route.polyline))
                    }
                } else {
                    if let error = error {
                        print(error)
                        AZEntrepriseServer.showError(controller: self, description: error.localizedDescription)
                    }
                }
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
