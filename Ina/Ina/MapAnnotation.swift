//
//  MapAnnotation.swift
//  Ina
//
//  Created by Zachary Skemp on 6/1/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var navImage: UIImage?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
        self.navImage = UIImage(named: "coteau")!
    }
}
