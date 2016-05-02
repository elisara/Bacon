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
    @IBOutlet weak var warningLabel: UITextView!
    
    
    let appDelegate     = UIApplication.sharedApplication().delegate as! AppDelegate
    var moc: NSManagedObjectContext?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        usernameField?.delegate = self
        passwordField?.delegate = self
        moc = appDelegate.managedObjectContext
        loginBtn.enabled = false
        warningLabel.hidden = true
        
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action:"back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    
    func back(sender: UIBarButtonItem) {
        let nextController = self.navigationController!.viewControllers[0]
        self.navigationController?.popToViewController(nextController, animated: true)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        warningLabel.hidden = true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        username = usernameField.text!
        password = passwordField.text!
        
        if (username != "" && password != ""){
        authentificate()
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
    
    func authentificate() {
        
        let userFetch = NSFetchRequest(entityName: "User")
        var correct = false
        
        do {
            let fetchedUsers = try moc!.executeFetchRequest(userFetch) as? [User]
            
            for User in fetchedUsers! {
                
                print("EntityUserData", User.userName)
                
                if (User.userName==username && User.password==password){
                    loginBtn.enabled = true
                    warningLabel.hidden = true
                    username = User.userName!
                    password = User.password!
                    correct = true
                
                }
                
            }
            if correct == false {
                //warningLabel.hidden = false
                print("username in test: ", username)
                print("password in test: ", username)
                let alertController = UIAlertController(title: "iBacon", message:
                    "Wrong username or password", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }

        } catch {
            fatalError("Failed to fetch users: \(error)")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "login"{
        let DestViewController: BrowseOrManageController = segue.destinationViewController as! BrowseOrManageController
        DestViewController.username = username
            }
    }
    
}

