//
//  VerificationViewController.swift
//  SwiftExample
//
//  Created by Ryan Lehman on 7/5/17.
//  Copyright © 2017 Charcoal Design. All rights reserved.
//

import UIKit
import Firebase

class VerificationViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    // Array that get's the passed user data from the previous view controller. This contains the user's email and password
    var passedData = [String]()
    
    // A function representing a button. When clicked looks to see if the user is verfied through email to login into the application
    @IBAction func reloadButton(_ sender: Any) {
        // Sign's the user in to get credentials and uses the passed data array to check which user
        Auth.auth().signIn(withEmail: passedData[0] , password: passedData[1]) { (user, error) in
            if let error = error {
                print("error")
                return
            }
            
            // Check's to see if the user has verfied the account and if they have then perform a segue and tranfer them into the app
            if (user?.isEmailVerified == true){
                self.spinner.stopAnimating()
                self.performSegue(withIdentifier: "verified", sender: nil)
            } else {
                // Else if the user is not verfied they can have the opporitunty to send the verfication again by creating an alert
                let verifyAlert = UIAlertController(title: "Not Verified", message: "Your account is not verified. Do you need us to resend you a verfication link?", preferredStyle: UIAlertControllerStyle.alert)
                
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
        spinner.startAnimating()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
