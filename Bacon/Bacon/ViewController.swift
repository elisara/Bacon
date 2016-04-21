//
//  ViewController.swift
//  Bacon
//
//  Created by iosdev on 24.3.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

// 1. Add the ESTBeaconManagerDelegate protocol
class ViewController: UIViewController, ESTBeaconManagerDelegate  {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var holderLabel: UILabel!
    @IBOutlet weak var descriptionField: UITextView!
    
    // 2. Add the beacon manager and the beacon region
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString: "DBB26A86-A7FD-45F7-AEEA-3A1BFAC8D6D9")!,
        identifier: "ranged region")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 3. Set the beacon manager's delegate
        self.beaconManager.delegate = self
        // 4. We need to request this authorization for every beacon manager
        self.beaconManager.requestAlwaysAuthorization()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion)
    }
    
    let placesByBeacons = [
        "6574:54631": [
            "Heavenly Sandwiches": 50, // read as: it's 50 meters from
            // "Heavenly Sandwiches" to the beacon with
            // major 6574 and minor 54631
            "Green & Green Salads": 150,
            "Mini Panini": 325
        ],
        "648:12": [
            "Heavenly Sandwiches": 250,
            "Green & Green Salads": 100,
            "Mini Panini": 20
        ],
        "17581:4351": [
            "Heavenly Sandwiches": 350,
            "Green & Green Salads": 500,
            "Mini Panini": 170
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
            //descriptionField.text = String("top lel")
            nameLabel?.text = String(nearestBeacon.rssi)
            holderLabel?.text = String(nearestBeacon.accuracy)
            descriptionField?.text = String(places)
            /*infoLabel.text = String(nearestBeacon)
             accuracyLabel.text = String(nearestBeacon.accuracy)
             proximityLabel.text = String(nearestBeacon.proximity)
             rssiLabel.text = String(nearestBeacon.rssi)
             nameLabel.text = String(nearestBeacon.proximityUUID)
             print(places) // TODO: remove after implementing the UI
             */
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
}