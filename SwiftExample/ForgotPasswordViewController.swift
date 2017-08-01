//
//  ForgotPasswordViewController.swift
//  SwiftExample
//
//  Created by Ryan Lehman on 7/5/17.
//  Copyright © 2017 Charcoal Design. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    // Sets up starting var.
    @IBOutlet weak var emailTextField: UITextField!
    var emailAddress = ""
    
    
    // A button function that send's the user a password change email
    @IBAction func sendEmailButton(_ sender: Any) {
        // Check's to see if email field is blank
        if (emailTextField.text != ""){
            emailAddress = emailTextField.text!
            
            // Send's the user a email with a new password field to enter in
            Auth.auth().sendPasswordReset(withEmail: emailAddress) { (error) in
                if let error = error {
                    let alert = UIAlertController(title: "Email Invalid", message: "Please enter your email again.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { action in
                        self.performSegue(withIdentifier: "backToLoginSegue", sender: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // Alerts the user if the email was sent and then take's them back to the login screen
                    let alert = UIAlertController(title: "Email Sent!", message: "Your email should be recived soon to reset your password", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "Awesome!", style: UIAlertActionStyle.default, handler: { action in
                        self.performSegue(withIdentifier: "backToLoginSegue", sender: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        } else {
            // Else it will diplay a message for the user to enter their email again if nothing was entered
            let alert = UIAlertController(title: "No Email Entered", message: "Please enter an email in box and try again. ", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Allows the user to close the keyboard
        emailTextField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("dismissKeyboard")))
        
    }
    
    // Function to close the keyboard if the user clicks on screen
    func dismissKeyboard(){
        emailTextField.resignFirstResponder()
        
    }
    
    // Function to close the keyboard if user clicks return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
