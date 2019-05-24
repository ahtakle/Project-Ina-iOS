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
        resource += [Location(name:"Head Start", address: "100 Veterans Memorial Dr",lat:45.5681150,long:-97.0669610  )]
        resource += [Location(name:"SWO Early Childhood Intervention", address: "Goodwill Township",lat:45.5677590,long: -97.0711610 )]
        resource += [Location(name:"IHS", address: "100 Lake Traverse Dr",lat:45.6568280,long: -97.0160580 )]
        resource += [Location(name:"Roberts County", address: "405 Chestnut St E",lat:45.6674190,long:-97.0457440  )]
        resource += [Location(name:"SWO Pride", address: "Dakota Ave",lat:45.5636240,long:-97.0763670  )]
        resource += [Location(name:"Coteau", address: "205 Orchard Dr",lat:45.657723,long: -97.050173 )]
        resource += [Location(name:"GPTCHB", address: "1770 Rand Rd",lat:44.101915,long: -103.263103 )]
        resource += [Location(name:"Little Steps Daycare", address: "100 Veterans Memorial Dr",lat:45.567646,long: -97.069341 )]
        resource += [Location(name:"WIC", address: "99-1 119th St",lat:45.660120,long: -97.050772 )]
    }
}
