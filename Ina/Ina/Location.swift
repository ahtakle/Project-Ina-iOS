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
    
    var title: String?
    var subtitle: String?
    //var navImage: UIImage?
    var coordinate: CLLocationCoordinate2D
    
    init(name:String, address:String, lat:CLLocationDegrees,long:CLLocationDegrees){
        title = name
        subtitle = address
        coordinate = CLLocationCoordinate2DMake(lat, long)
        //self.navImage = UIImage(named: "coteau")!
    }
}

class LocationList: NSObject {
    var resource = [Location]()
    override init(){
        resource += [Location(name:"Head Start", address: "123 Sisseton",lat:45.5681150,long:-97.0669610  )]
        resource += [Location(name:"Tribal Admin Building", address: "123 Sisseton",lat:45.5677590,long: -97.0711610 )]
        resource += [Location(name:"test1", address: "123 Sisseton",lat:45.6568280,long: -97.0160580 )]
        resource += [Location(name:"SWO Health Nurse Clinic", address: "123 Sisseton",lat:45.6674190,long:-97.0457440  )]
        resource += [Location(name:"Dakota Pride Center", address: "123 Sisseton",lat:45.5636240,long:-97.0763670  )]
    }
}
