//
//  Location.swift
//  Ina
//
//  Created by Zachary Skemp on 5/13/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//

import UIKit
import MapKit

class Location: NSObject, MKAnnotation{
    var identifier = "resource location"
    var title: String?
    var coordinate: CLLocationCoordinate2D
    init(name:String,lat:CLLocationDegrees,long:CLLocationDegrees){
        title = name
        coordinate = CLLocationCoordinate2DMake(lat, long)
    }
}

class LocationList: NSObject {
    var resource = [Location]()
    override init(){
        resource += [Location(name:"Head Start",lat:45.5681150,long:-97.0669610  )]
        resource += [Location(name:"Tribal Admin Building",lat:45.5677590,long: -97.0711610 )]
        resource += [Location(name:"IHS",lat:45.6568280,long: -97.0160580 )]
        resource += [Location(name:"SWO Health Nurse Clinic",lat:45.6674190,long:-97.0457440  )]
        resource += [Location(name:"Dakota Pride Center",lat:45.5636240,long:-97.0763670  )]
    }
}
