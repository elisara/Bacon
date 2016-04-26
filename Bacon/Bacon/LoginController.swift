//
//  LoginController.swift
//  Bacon
//
//  Created by iosdev on 21.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LoginController: UIViewController, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    
    var username = ""
    var password = ""
    
    
    //@IBOutlet weak var adminBtn: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var asAdminBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        asAdminBtn.hidden = true
        usernameField?.delegate = self
        passwordField?.delegate = self
        
    }
    /*
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let managedObjectContext = NSManagedObjectContext()
        let moc = managedObjectContext
        let userFetch = NSFetchRequest(entityName: "User")
        
        do {
            let fetchedUsers = try moc.executeFetchRequest(userFetch) as? [User]
        } catch {
            fatalError("Failed to fetch users: \(error)")
        }
    }*/
    
    func textFieldDidEndEditing(textField: UITextField) {
        username = usernameField.text!
        password = passwordField.text!
        
        if username == "admin" && password == "admin"{
        asAdminBtn.hidden = false
        }
    
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    }
    


