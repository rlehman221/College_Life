//
//  SideViewController.swift
//  SwiftExample
//
//  Created by Kadeem Palacios on 7/10/17.
//  Copyright © 2017 Charcoal Design. All rights reserved.
//

import UIKit
import Firebase

class SideViewController: UIViewController {
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    var mainViewController : UIViewController!
    var ref = Database.database().reference()
    var username = "hi"
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var slideoutButton: UIButton!
    let firebaseAuth = Auth.auth()
    
    @IBAction func requestFeaturesButton(_ sender: Any) {
        let alert = UIAlertController(title: "Request A Feature", message: "Please enter a feature or service you wish to see on College Life.", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let sendingData = String(describing: textField?.text)
            
            self.ref.child("FeaturesUsersWant").child(sendingData).setValue("1")
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func logoutButton(_ sender: Any) {
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
        
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = mainStoryBoard.instantiateViewController(withIdentifier: "LoginView")
        self.present(viewController, animated: true, completion: nil)
        print("Logged out")
    }
    
    // Function to download users profile pictures
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageUrlString = "http://cdn.playbuzz.com/cdn/38402fff-32a3-4e78-a532-41f3a54d04b9/cc513a85-8765-48a5-8481-98740cc6ccdc.jpg"
        
        let url = URL(string: imageUrlString)
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if (error != nil) {
                print("Error")
            } else {
                var documentsDirectory: String?
                
                var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                
                if paths.count > 0 {
                    documentsDirectory = paths[0]
                    
                    let savePath = documentsDirectory! + "/newIMage"
                    
                    FileManager.default.createFile(atPath: savePath, contents: data, attributes: nil)
                    
                    DispatchQueue.main.sync {
                        self.profilePicture.image = UIImage(named: savePath)
                    }
                }
            }
        })
        
        
        task.resume()
        
        slideoutButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            username = user.displayName!
            
            var userUrl = user.photoURL
            print(username)
            print(userUrl)
                    }
        usernameLabel.text = username
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeSideWindow(_ sender: Any) {
        
        self.slideMenuController()?.closeLeft()
    }
    
    
    

}
