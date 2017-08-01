//
//  LoginViewController.swift
//  SwiftExample
//
//  Created by Ryan Lehman on 6/26/17.
//  Copyright © 2017 Charcoal Design. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate{
    var ref: DatabaseReference!
    
    // Creates variables for each of the storyboard features
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var segementedController: UISegmentedControl!
    
    // College Database
    var collegeEmails = ["@rpi.edu","@scarletmail.rutgers.edu", "@aol.com", "@rutgers.edu"]
    
    // Boolean value to keep track if user email is correct (if not invalid notifcation pops up)
    var validBoolean = false
    // A  array which will hold the email and password of the registered user and pass that to the next view controller
    var loginCriteria = [String]()
    
    var email = ""
    var password = ""
    
    // A function to create user, send email, and move to next view controller
    @IBAction func registerButton(_ sender: Any) {
        email = emailTextField.text!
        password = passwordTextField.text!
        if (passwordTextField.text == "" || confirmPasswordField.text == "" || emailTextField.text == "" || usernameTextField.text == ""){
            let alert = UIAlertController(title: "Not All Fields Completed", message: "Please fill in all fields below and try again.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            if (usernameTextField.text?.contains(" "))!{
                let alert = UIAlertController(title: "Invalid Username", message: "Username can not contain spaces.", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            } else {
                Database.database().reference().child("UsernameDataBase").observeSingleEvent(of: .value, with: { (snapshot) in
                    if let dict2 = snapshot.value as? [String: AnyObject] {
                        
                        let postCount = dict2
                        if (postCount.keys.contains(self.usernameTextField.text!) == false) {
                            if (self.emailTextField.text?.contains("@"))! {
                                var lowerCaseEmail = self.emailTextField.text?.lowercased()
                                let number = lowerCaseEmail?.characters.index(of: "@")
                                let newEmail = lowerCaseEmail?.substring(from: number!)
                                let testEmail = String(describing: newEmail!)
                                
                                // If user enters a gmail account they are notified to not use that account
                                if testEmail.contains("@gmail.com"){
                                    let alert = UIAlertController(title: "No Gmail Accounts Allowed", message: "Please enter your RPI or Rutgers email and try again.", preferredStyle: UIAlertControllerStyle.alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                    
                                } else {
                                    
                                    // Walks through the college arrays to see if the email is valid to be a user
                                    for index in self.collegeEmails {
                                        
                                        if (index.contains(testEmail)){
                                            self.validBoolean = true
                                            // Creates the user and add's them into the firebase database
                                            Auth.auth().createUser(withEmail: self.email , password: self.password) { (user, error) in
                                                if let error = error {
                                                    let Erroralert = UIAlertController(title: "Email Already Exists", message: "Please enter an email that doesn't already exist.", preferredStyle: UIAlertControllerStyle.alert)
                                                    
                                                    Erroralert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                                                    self.present(Erroralert, animated: true, completion: nil)
                                                    
                                                    
                                                } else {
                                                    
                                                    print("created User")
                                                    let userID : [String: AnyObject] = ["Email": self.emailTextField.text as AnyObject]
                                                    //Implement a feature to check username and service to see if they already posted in a category
                                                    self.ref = Database.database().reference()
                                                    self.ref.child("Users").child(self.usernameTextField.text!).setValue(userID)
                                                    
                                                    self.ref.child("UsernameDataBase").child(self.usernameTextField.text!).setValue("1")
                                                    
                                                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                                    changeRequest?.displayName = self.usernameTextField.text
                                                    
                                                    // Will be used later to store users profile pictures
                                                    let url = URL(string: "https://drive.google.com/file/d/0B92YfEXnvbntN0RnV1NjRHVqUUE/view?usp=sharing")
                                                    changeRequest?.photoURL = url
                                                    changeRequest?.commitChanges { (error) in
                                                        print("Created displayname")
                                                    }
                                                    
                                                    // Sends the same user a verication email to confirm on their end
                                                    user?.sendEmailVerification(completion: { (error) in
                                                        print("sent email")
                                                    })
                                                    self.loginCriteria.append(self.email)
                                                    self.loginCriteria.append(self.password)
                                                    self.performSegue(withIdentifier: "registerToVerifySegue", sender: self.loginCriteria)
                                                    
                                                }
                                                
                                                
                                                
                                                
                                            }
                                            
                                            // Once the email has sent, the view controller changes and sends the user's data with it
                                            
                                            
                                            
                                        }
                                    }
                                    
                                    // If end of user email is not apart of college database
                                    if (self.validBoolean == false) {
                                        let alert2 = UIAlertController(title: "Invalid Email", message: "Please enter your RPI or Rutgers email and try again.", preferredStyle: UIAlertControllerStyle.alert)
                                        
                                        alert2.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                                        self.present(alert2, animated: true, completion: nil)
                                    }
                                    
                                }
                                
                            } else {
                                // Else user get's message showing how they need a college email to enter the app
                                //Invalid email try again if their is no @ sign in email text field
                                let alert = UIAlertController(title: "Invalid Email", message: "Please enter your RPI or Rutgers email and try again.", preferredStyle: UIAlertControllerStyle.alert)
                                
                                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else{
                            let sameUsernameAlert = UIAlertController(title: "Username Already Taken", message: "The username you have entered is not available, enter a new username.", preferredStyle: UIAlertControllerStyle.alert)
                            
                            sameUsernameAlert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                            self.present(sameUsernameAlert, animated: true, completion: nil)
                        }
                    }
                    
                })
                
            }
            if (passwordTextField.text == confirmPasswordField.text){
                // Parse's out email to check if everything including @ and -> is valid with school's added
                
            } else {
                let badPasswordAlert = UIAlertController(title: "Passwords Don't Match", message: "These passwords don't match.", preferredStyle: UIAlertControllerStyle.alert)
                
                badPasswordAlert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                self.present(badPasswordAlert, animated: true, completion: nil)
            }
            
            
            

        }
            }
    
    //  A function to change screen's if the user press's the sign in segment button
    @IBAction func changedIndex(_ sender: UISegmentedControl) {
        switch segementedController.selectedSegmentIndex {
        case 0:
            
            print("Sign Uppp")
        case 1:
            performSegue(withIdentifier: "signInSeque", sender: nil)
            print("Sign Innnn")
        default:
            break
        }
        
    }
    
    // Prepares the controller to send data (the login credentials) to the next view controller to wait for email verifcation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "registerToVerifySegue" {
            if let destination = segue.destination as? VerificationViewController {
                destination.passedData = (sender as? Array)!
            }
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Allows the user to close the keyboard
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("dismissKeyboard")))
        
    }
    
    // Function to close the keyboard if the user clicks on screen
    func dismissKeyboard(){
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
        
    }
    
    // Function to close the keyboard if user clicks return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
        return true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

