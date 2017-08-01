//
//  BeautyCategoryViewController.swift
//  College-Life
//
//  Created by Ryan Lehman on 6/25/17.
//  Copyright © 2017 Ubiquity. All rights reserved.
//

import UIKit

class BeautyCategoryViewController: UIViewController {
    var white = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)

    @IBOutlet weak var SecondCat: UIButton!
    @IBOutlet weak var FirstCat: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       // FirstCat.layer.borderColor = white.cgColor
      //  SecondCat.layer.borderColor = white.cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func MenuDismissalPressed(_ sender: Any) {
   
    dismiss(animated: true, completion: nil)
    }
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        print("touched")
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
