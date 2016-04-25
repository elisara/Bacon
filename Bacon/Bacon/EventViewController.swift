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
        
        if let event = event{
            eventNameLabel.text! = event.name
            iconView.image = UIImage(named: "heart")!
            eventImageView.image = UIImage(named: "blue2")!
            descriptionView.text! = event.eventDescription
            
            print(event.name)
            print(event.eventDescription)

        }
        else{
            print("Ei onnitunut")
        }
       
    }
    
    @IBAction func startButton(sender: UIButton) {
    }
    
}
