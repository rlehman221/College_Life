//
//  LoginView.swift
//  SwiftExample
//
//  Created by Ryan Lehman on 7/5/17.
//  Copyright © 2017 Charcoal Design. All rights reserved.
//

import UIKit
import Firebase

class LoginView: UIViewController, UITextFieldDelegate {

    // Set's up storyboard varaibles
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var segementedController: UISegmentedControl!
    
    var email = ""
    var password = ""
    
    // Function to see if the user has clicked the sign up button to switch them over to another view controller on the segmented button
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segementedController.selectedSegmentIndex {
        case 0:
            print("Sign Innnnn")
        case 1:
            performSegue(withIdentifier: "registerSegue", sender: nil)
            print("Sign Uppppp")
        default:
            break
        }
    }

    // Button function to sign in the user into the app but check's to see if they are a user and are verfied
    @IBAction func loginButton(_ sender: Any) {
        var alertBoolean = false
        email = emailTextField.text!
        password = passwordTextField.text!
        
        // Sign's in the user to the database
        Auth.auth().signIn(withEmail: email , password: password) { (user, error) in
            if let error = error {
                
                // If an error occur's the user is not a user and they get alerted to try again
                let alert = UIAlertController(title: "Incorrect Login", message: "The password or email you have entered is incorrect. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                alertBoolean = true
                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("user not signed in")
                return
            }
        
            // Check's to see if the user is verfied
            if (user?.isEmailVerified == true && alertBoolean == false){
                self.performSegue(withIdentifier: "loginVerified", sender: nil)
                
            } else if (user?.isEmailVerified == false) {
                let verifyAlert = UIAlertController(title: "Not Verified", message: "Your account is not verified. Do you need us to resend you a verfication link?", preferredStyle: UIAlertControllerStyle.alert)
                
                // If the user want's they can be sent a new verfication email
                verifyAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
                    //run your function here
                    user?.sendEmailVerification(completion: { (error) in
                        print("Sent another email verfication")
                    })
                    }))
                
                verifyAlert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { action in
                    //run your function here
                }))

                self.present(verifyAlert, animated: true, completion: nil)
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Allows the user to close the keyboard
        emailTextField.delegate = self
        passwordTextField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("dismissKeyboard")))
        // Do any additional setup after loading the view.
    }
    
    // Function to close the keyboard if the user clicks on screen
    func dismissKeyboard(){
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
    }
    
    // Function to close the keyboard if user clicks return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        return true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
