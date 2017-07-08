//
//  MapController.swift
//  Ina
//
//  Created by Zachary Skemp on 5/13/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//

import UIKit
import MapKit
import QuickLook

class MapController: UIViewController, MKMapViewDelegate, QLPreviewControllerDataSource {

    
    @IBOutlet weak var mapView: MKMapView!
    
    let ql = QLPreviewController()
    //Global var to select PDF by name
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        let locations = LocationList().resource
        mapView.addAnnotations(locations)
        
        //Set up the PDF Viewer when clicking
        ql.dataSource  = self
        
        // set initial location in Sisseton
        let initialLocation = CLLocation(latitude: 45.6568, longitude: -97.0160)
        centerMapOnLocation(location: initialLocation)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //Changes variable to find correct PDF
        name = view.annotation!.title!!
        //Refreshes which PDF Quicklook should display
        ql.refreshCurrentPreviewItem()
        //Pushes new Quicklook preview over glossarylist (stays in same nav controller)
        navigationController?.pushViewController(ql, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "mapAnnotation"
        
        if annotation is Location {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                let btn = UIButton(type: .detailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            } else {
                annotationView!.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 40.0, regionRadius * 40.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    //QL Protocol Methods
    func numberOfPreviewItems(in: QLPreviewController) -> Int{
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let mainbundle = Bundle.main
        //Picks file based on global var name which is changed in didSelectRowAt
        let url = mainbundle.path(forResource: name, ofType: "pdf")!
        let doc = NSURL(fileURLWithPath: url)
        return doc
    }
    
}
