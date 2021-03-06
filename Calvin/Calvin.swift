//
//  LeCiteDeCalvin.swift
//  Calvin
//
//  Created by Arion Zimmermann on 05.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import MapKit
import UIKit

class Calvin : NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    override init() {
        self.title = "Calvin"
        self.coordinate = CLLocationCoordinate2D(latitude: 46.2008 , longitude: 6.151)
        self.info = "Calvin, la cité de Genève"
    }
}
