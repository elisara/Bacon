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

class MapViewController: UIViewController, ESTBeaconManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var checkpointButton: UIButton!
    
    @IBOutlet weak var hint1View: UITextView!
    @IBOutlet weak var hint2View: UITextView!
    @IBOutlet weak var extraHintBtn: UIButton!
    
    
    var eventID = Int()
    var extraSeen = false
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 1.0, regionRadius * 1.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    //1
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
        identifier: "ranged region")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hint1View.hidden = true
        hint2View.hidden = true
        extraHintBtn.hidden = true
        // set initial location to Metropolia
        let initialLocation = CLLocation(latitude: 60.221803, longitude: 24.804408)
        centerMapOnLocation(initialLocation)
        // 3. Set the beacon manager's delegate
        self.beaconManager.delegate = self
        // 4. We need to request this authorization for every beacon manager
        self.beaconManager.requestAlwaysAuthorization()
        
        print(eventID)
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action:"back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    
    func back(sender: UIBarButtonItem) {
        let nextController = self.navigationController!.viewControllers[4] as! EventViewController
        self.navigationController?.popToViewController(nextController, animated: true)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion)
    }
    
    
    @IBAction func hintAction(sender: UIButton) {
        if hint1View.hidden == true && extraSeen == false{
        hint1View.hidden = false
        extraHintBtn.hidden = false
        }
        else if hint1View.hidden == false && extraSeen == false{
            hint1View.hidden = true
            extraHintBtn.hidden = true
        }
        else if hint1View.hidden == true && extraSeen == true{
            hint1View.hidden = false
            hint2View.hidden = false
            extraHintBtn.hidden = false
        }
        else if hint1View.hidden == false && extraSeen == true{
            hint1View.hidden = true
            hint2View.hidden = true
            extraHintBtn.hidden = true
        }
        
    }
    
    
    
    @IBAction func extraHintAction(sender: UIButton) {
        extraSeen = true
        hint2View.hidden = false
        extraHintBtn.enabled = true
    }
    
    
    let placesByBeacons = [
        "57832:7199": [
            "Blueberry beacon": 250,
        ],
        "911:912": [
            "Mint Beacon": 350,
        ],
        "1319:50423": [
            "Huutista!": 50, // read as: it's 50 meters from
            // "Heavenly Sandwiches" to the beacon with
            // major 6574 and minor 54631
            "Green & Green Salads": 150,
            "Mini Panini": 325
        ]
    ]
    
    func placesNearBeacon(beacon: CLBeacon) -> [String] {
        let beaconKey = "\(beacon.major):\(beacon.minor)"
        if let places = self.placesByBeacons[beaconKey] {
            let sortedPlaces = Array(places).sort() { $0.1 < $1.1 }.map { $0.0 }
            return sortedPlaces
        }
        return []
    }
    
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon],
                       inRegion region: CLBeaconRegion) {
        if let nearestBeacon = beacons.first {
            let places = placesNearBeacon(nearestBeacon)
            // TODO: update the UI here
            print("Ennen if: ", nearestBeacon.major)
            if (places.first != nil){
                print("ifissä: ", places.first)
                checkpointButton.hidden = false
            }
            else {
                checkpointButton.hidden = true
            }
        }
    }
    
    func manageBeacons(manager: AnyObject, didRangeBeacons beacons: [CLBeacon],
                       inRegion region: CLBeaconRegion) {
        if let nearestBeacon = beacons.first {
            let places = placesNearBeacon(nearestBeacon)
            // TODO: update the UI here
            print(places) // TODO: remove after implementing the UI
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let DestViewController: CheckpointViewController = segue.destinationViewController as! CheckpointViewController
        DestViewController.eventID = eventID
    }
    
}

