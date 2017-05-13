//
//  MapController.swift
//  Ina
//
//  Created by Zachary Skemp on 5/13/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//

import Foundation

import UIKit
import MapKit

class MapController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let locations = LocationList().resource
        mapView.addAnnotations(locations)
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 45.6568, longitude: -97.0160)
        centerMapOnLocation(location: initialLocation)
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 12.0, regionRadius * 12.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    
    
}
