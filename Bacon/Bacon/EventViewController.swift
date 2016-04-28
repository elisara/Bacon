//
//  EventViewController.swift
//  Bacon
//
//  Created by iosdev on 13.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit

class EventViewController: UIViewController {
    
    
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    
    var event = EventObject?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        
        //if let event = event{
        eventNameLabel.text! = event!.name
    
        if event!.type == "Sport"{
            iconView.image = UIImage(named: "trophy")!
        }
        else if event!.type == "Art"{
            iconView.image = UIImage(named: "paint")!
        }
        else if event!.type == "Sightseeing"{
            iconView.image = UIImage(named: "sight")!
        }
        else if event!.type == "Adventure"{
            iconView.image = UIImage(named: "treasure")!
        }
        else if event!.type == "Drinking"{
            iconView.image = UIImage(named: "drinking")!
        }
        else{
            iconView.image = UIImage(named: "heart")!
        }
        
        eventImageView.image = UIImage(named: "blue2")!
        descriptionView.text! = event!.eventDescription
        
        print(event!.name)
        print(event!.eventDescription)
        
        /*}
         else{
         print("Ei onnitunut")
         }
         */
        print("EventViewController: ", event?.eventId)
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action:"back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    
    func back(sender: UIBarButtonItem) {
        let nextController = self.navigationController!.viewControllers[3] as! EventTableViewController
        self.navigationController?.popToViewController(nextController, animated: true)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let DestViewController: MapViewController = segue.destinationViewController as! MapViewController
        DestViewController.eventID = (event?.eventId)!
        DestViewController.numberOfCheckpoints = (event?.numberOfCheckpoints)!
    }
    
    
    @IBAction func startButton(sender: UIButton) {
    }
    
}


