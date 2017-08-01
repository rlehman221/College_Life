//
//  ServiceUsersViewController.swift
//  SwiftExample
//
//  Created by Ryan Lehman on 6/25/17.
//  Copyright © 2017 Charcoal Design. All rights reserved.
//

import UIKit
import Firebase

class ServiceUsersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var pricePerService: UITextField!
    
    let services = ["Beauty","Tutoring", "Driving"]
    var name = "beauty"
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return services[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return services.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        name = String(services[row])
        print(name)
    }
    @IBAction func nextPageButton(_ sender: Any) {
        if (name == "Beauty"){
            performSegue(withIdentifier: "beautySegue", sender: nil)
            
        } else if (name == "Tutoring"){
            performSegue(withIdentifier: "tutoringSegue", sender: nil)
        } else if (name == "Driving") {
            performSegue(withIdentifier: "drivingSegue", sender: nil)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
