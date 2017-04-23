//
//  Restaurant.swift
//  Calvin
//
//  Created by Arion Zimmermann on 12.04.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import MapKit
import UIKit

class Restaurant : NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.title = name
        self.coordinate = CLLocationCoordinate2D(latitude: latitude , longitude: longitude)
    }
}
