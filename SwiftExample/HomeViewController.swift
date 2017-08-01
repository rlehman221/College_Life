//
//  ViewController2.swift
//  SwiftExample
//
//  Created by Ryan Lehman on 6/25/17.
//  Copyright © 2017 Charcoal Design. All rights reserved.
//

import UIKit
import Firebase

class  HomeViewController: UIViewController {
    
    var ref: DatabaseReference!
    @IBOutlet weak var slideoutButton: UIButton!
    
    let firebaseAuth = Auth.auth()
    
    
    
    @IBAction func slideoutButton(_ sender: Any) {
        slideMenuController()?.openLeft()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        slideoutButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
