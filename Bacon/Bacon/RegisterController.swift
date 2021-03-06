//
//  RegisterController.swift
//  Bacon
//
//  Created by iosdev on 22.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit
import Security
import CoreData


class RegisterController: UIViewController, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    
    var allInfo = ""
    var username = ""
    var password = ""
    var password2 = ""
    var email = ""
    
    var usernameList: [String]  = []
    
    let appDelegate     = UIApplication.sharedApplication().delegate as! AppDelegate
    var moc: NSManagedObjectContext?
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var password2Field: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        password2Field.delegate = self
        registerBtn.enabled = false
        
        moc = appDelegate.managedObjectContext
        
        fetchUsers()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action:"back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    
    func back(sender: UIBarButtonItem) {
        let nextController = self.navigationController!.viewControllers[1] as! LoginController
        self.navigationController?.popToViewController(nextController, animated: true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        password2Field.resignFirstResponder()
        
        return true
    }
    
    func fetchUsers(){
        let userFetch = NSFetchRequest(entityName: "User")
        
        do {
            let fetchedUsers = try moc!.executeFetchRequest(userFetch) as? [User]
            for User in fetchedUsers! {
                
                print("EntityUserData", User.userName)
                usernameList.append(User.userName!)
            }
        } catch {
            fatalError("Failed to fetch users: \(error)")
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        username = usernameField.text!
        print("Username: ", username)
        email = emailField.text!
        print("Email: ", email)
        password = passwordField.text!
        password2 = password2Field.text!
        
        testRegisteration()
        
    
    }
    
    func testRegisteration(){
        
        if usernameList.contains(username){
            let alertController = UIAlertController(title: "iBacon", message:
                "Username is already in use", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
                    }
        
        if password == password2 && password != "" && !usernameList.contains(username) && username != "" && email != ""{
            registerBtn.enabled = true
            
        }
        if password != password2 && password2 != ""{
            let alertController = UIAlertController(title: "iBacon", message:
                "Confirming password failed", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
           
            
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func registerAction(sender: UIButton) {
        let myPost = myHTTPPost()
        allInfo = "<user><email>\(email)</email><password>\(password)</password><userName>\(username)</userName></user> "
        print("Allinfo in register: ", allInfo)
        myPost.postData(allInfo, urlExtension: "User")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let DestViewController: BrowseOrManageController = segue.destinationViewController as! BrowseOrManageController
            DestViewController.username = username
        
    }
    
    
}