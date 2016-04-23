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

class RegisterController: UIViewController, UITextFieldDelegate {
    
    var allInfo = ""
    var username = ""
    var password = ""
    var password2 = ""
    var email = ""
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var password2Field: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //adminBtn.hidden = true
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        password2Field.delegate = self
        
        registerBtn.enabled = false
        
        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        password2Field.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        username = usernameField.text!
        print("Username: ", username)
        email = emailField.text!
        print("Email: ", email)
        password = passwordField.text!
        password2 = password2Field.text!
        
        if password == password2 && password != ""{
            registerBtn.enabled = true
   
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
    
    
}