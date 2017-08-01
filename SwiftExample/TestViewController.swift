//
//  TestViewController.swift
//  SwiftExample
//
//  Created by Ryan Lehman on 6/27/17.
//  Copyright © 2017 Charcoal Design. All rights reserved.
//

import UIKit
import Firebase

class TestViewController: UIViewController {

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().signIn(withEmail: "ryanschat77@gmail.com", password: "12345") {
            (user, error) in
            print("HELLLLLOOOOO")
            if let user = Auth.auth().currentUser {
                print("HELLLLLOOOOO2")
                Auth.auth().currentUser?.sendEmailVerification { (error) in
                    print("sent email")
                }
                if !user.isEmailVerified{
                    let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \("ryanschat77@gmail.com").", preferredStyle: .alert)
                    let alertActionOkay = UIAlertAction(title: "Okay", style: .default) {
                        (_) in
                        user.sendEmailVerification(completion: nil)
                    }
                    let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                    
                    alertVC.addAction(alertActionOkay)
                    alertVC.addAction(alertActionCancel)
                    self.present(alertVC, animated: true, completion: nil)
                } else {
                    print ("Email verified. Signing in...")
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
