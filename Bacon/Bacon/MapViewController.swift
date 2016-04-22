//
//  MapViewController.swift
//  Bacon
//
//  Created by iosdev on 22.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 1.0, regionRadius * 1.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // set initial location to Metropolia
        let initialLocation = CLLocation(latitude: 60.221803, longitude: 24.804408)
        centerMapOnLocation(initialLocation)
    }
    
    
    
    
}