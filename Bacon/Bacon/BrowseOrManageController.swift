//
//  BrowseOrManageController.swift
//  Bacon
//
//  Created by iosdev on 27.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit

class BrowseOrManageController: UIViewController {
    
    
    
    @IBOutlet weak var manageBtn: UIButton!
    var username = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageBtn.hidden = true
        if username == "admin"{
            
            manageBtn.hidden = false
        }
        
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action:"back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    
    func back(sender: UIBarButtonItem) {
        let nextController = self.navigationController!.viewControllers[1] as! LoginController
        self.navigationController?.popToViewController(nextController, animated: true)
        
        
    }
}
