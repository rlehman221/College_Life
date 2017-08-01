//
//  DrivingPostingsViewController.swift
//  SwiftExample
//
//  Created by Ryan Lehman on 7/27/17.
//  Copyright © 2017 Charcoal Design. All rights reserved.
//

import UIKit
import paper_onboarding
class DrivingPostingsViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate, UITextFieldDelegate{

    
    
    
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var shotgunLabel: UILabel!
    @IBOutlet weak var enterAvaliableSeatsLavel: UILabel!
    @IBOutlet weak var haveAvaLabel: UILabel!
    @IBOutlet weak var tapTheNumberOfLabel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var shotgunSeat: UIButton!
    @IBOutlet weak var drivingSeat: UIImageView!
    @IBOutlet weak var dollarImage: UIImageView!
    @IBOutlet weak var enterAPricePerSeatLabel: UILabel!
    @IBOutlet weak var underscoreLabel: UILabel!
    @IBOutlet weak var dollarLabel: UILabel!
    @IBOutlet weak var priceInput: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var markerImage: UIImageView!
    @IBOutlet weak var enterADestLabel: UILabel!
    @IBOutlet weak var enterTheDestLabel: UILabel!
    @IBOutlet weak var headingToLabel: UILabel!
    @IBOutlet weak var ifNoPlaceLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var noPlaceButton: UIButton!
    @IBOutlet weak var pickTheTimeAndLabel: UILabel!
    @IBOutlet weak var areYouTravelingLabel: UILabel!
    @IBOutlet weak var enterScheduleLabel: UILabel!
    @IBOutlet weak var calendarImage: UIImageView!
    
    
    @IBOutlet weak var middleLeftSeat: UIButton!
    @IBOutlet weak var middleMiddleSeat: UIButton!
    @IBOutlet weak var middleRightSeat: UIButton!
    @IBOutlet weak var backLeftSeat: UIButton!
    @IBOutlet weak var backMiddleSeat: UIButton!
    @IBOutlet weak var backRightSeat: UIButton!
    @IBOutlet weak var drivingView: DrivingPost!
    var firstSeatBool = false
    var secondSeatBool = false
    var thirdSeatBool = false
    var fourthSeatBool = false
    var fifthSeatBool = false
    var sixthSeatBool = false
    var seventhSeatBool = false
    var destinationCheckBool = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        drivingView.dataSource = self
        drivingView.delegate = self
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.priceInput.delegate = self
        
        //drivingView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func onboardingItemsCount() -> Int {
        return 4
    }

    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor(red: 217/255, green: 72/255, blue: 89/255, alpha: 1)
        let backgroundColorTwo = UIColor(red: 106/255, green: 166/255, blue: 211/255, alpha: 1)
        let backgroundColorThree = UIColor(red: 106/255, green: 221/255, blue: 211/255, alpha: 1)
        let backgroundColorFour = UIColor(red: 168/255, green: 200/255, blue: 78/255, alpha: 1)
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont2 = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        
        return[(imageName: #imageLiteral(resourceName: "fake"), title: "", description: "", iconName: #imageLiteral(resourceName: "fake"), color: backgroundColorOne, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont2),
               
               (imageName: #imageLiteral(resourceName: "fake"), title: "", description: "", iconName: #imageLiteral(resourceName: "fake"), color: backgroundColorTwo, titleColor: UIColor.red, descriptionColor: UIColor.red, titleFont: titleFont, descriptionFont: descriptionFont2),
               
               (imageName: #imageLiteral(resourceName: "fake"), title: "", description: "", iconName: #imageLiteral(resourceName: "fake"), color: backgroundColorThree, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont2),
               
               (imageName: #imageLiteral(resourceName: "fake"), title: "", description: "", iconName: #imageLiteral(resourceName: "fake"), color: backgroundColorFour, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont2)][index]
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        //
    }
    
    
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        
        if index == 3 {
            UIView.animate(withDuration: 0.4, animations: {
                self.priceInput.alpha = 1
                self.dollarLabel.alpha = 1
                self.underscoreLabel.alpha = 1
                self.enterAPricePerSeatLabel.alpha = 1
                self.dollarImage.alpha = 1
                
                
            })
        }
        
        if index == 2 {
            UIView.animate(withDuration: 0.4, animations: {
                self.drivingSeat.alpha = 1
                self.shotgunSeat.alpha = 1
                self.middleLeftSeat.alpha = 1
                self.middleMiddleSeat.alpha = 1
                self.middleRightSeat.alpha = 1
                self.backLeftSeat.alpha = 1
                self.backMiddleSeat.alpha = 1
                self.backRightSeat.alpha = 1
                self.carImage.alpha = 1
                self.tapTheNumberOfLabel.alpha = 1
                self.haveAvaLabel.alpha = 1
                self.enterAvaliableSeatsLavel.alpha = 1
                self.shotgunLabel.alpha = 1
                self.driverLabel.alpha = 1
                
            })
        }
        
        if index == 1 {
            UIView.animate(withDuration: 0.4, animations: {
                self.calendarImage.alpha = 1
                self.areYouTravelingLabel.alpha = 1
                self.pickTheTimeAndLabel.alpha = 1
                self.enterScheduleLabel.alpha = 1
                self.datePicker.alpha = 1
                
                
            })
        }
        
        if index == 0 {
            UIView.animate(withDuration: 0.4, animations: {
                self.locationTextField.alpha = 1
                self.noPlaceButton.alpha = 1
                self.ifNoPlaceLabel.alpha = 1
                self.headingToLabel.alpha = 1
                self.enterTheDestLabel.alpha = 1
                self.enterADestLabel.alpha = 1
                self.markerImage.alpha = 1
            })
        }
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if (index == 1 || index == 0 || index == 3 || index == 4) {
            
            if self.middleLeftSeat.alpha == 1 {
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.drivingSeat.alpha = 0
                    self.shotgunSeat.alpha = 0
                    self.middleLeftSeat.alpha = 0
                    self.middleMiddleSeat.alpha = 0
                    self.middleRightSeat.alpha = 0
                    self.backLeftSeat.alpha = 0
                    self.backMiddleSeat.alpha = 0
                    self.backRightSeat.alpha = 0
                    self.carImage.alpha = 0
                    self.tapTheNumberOfLabel.alpha = 0
                    self.haveAvaLabel.alpha = 0
                    self.enterAvaliableSeatsLavel.alpha = 0
                    self.shotgunLabel.alpha = 0
                    self.driverLabel.alpha = 0
                    
                })
            }
            
        }
        if (index == 1 || index == 2 || index == 3 || index == 4) {
            
            if self.locationTextField.alpha == 1 {
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.locationTextField.alpha = 0
                    self.noPlaceButton.alpha = 0
                    self.ifNoPlaceLabel.alpha = 0
                    self.headingToLabel.alpha = 0
                    self.enterTheDestLabel.alpha = 0
                    self.enterADestLabel.alpha = 0
                    self.markerImage.alpha = 0
                    
                })
            }
            
        }
        
        if (index == 2 || index == 0 || index == 3 || index == 4) {
            
            if self.calendarImage.alpha == 1 {
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.calendarImage.alpha = 0
                    self.areYouTravelingLabel.alpha = 0
                    self.pickTheTimeAndLabel.alpha = 0
                    self.enterScheduleLabel.alpha = 0
                    self.datePicker.alpha = 0
                    
                })
            }
            
        }
        
        if (index == 0 || index == 1 || index == 2 || index == 4) {
            
            if self.dollarImage.alpha == 1 {
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.priceInput.alpha = 0
                    self.dollarLabel.alpha = 0
                    self.underscoreLabel.alpha = 0
                    self.enterAPricePerSeatLabel.alpha = 0
                    self.dollarImage.alpha = 0
                    
                })
            }
            
        }
       
        
    }
    
  
    
    @IBAction func firstSeatClicked(_ sender: Any) {
        if (firstSeatBool == false){
            shotgunSeat.setImage(#imageLiteral(resourceName: "Clicked-Passenger"), for: .normal)
            firstSeatBool = true
            
        } else {
            shotgunSeat.setImage(#imageLiteral(resourceName: "Unclicked-Passenger"), for: .normal)
            firstSeatBool = false
        }
    }
    
    @IBAction func secondSeatClicked(_ sender: Any) {
        if (secondSeatBool == false){
            middleLeftSeat.setImage(#imageLiteral(resourceName: "Clicked-Passenger"), for: .normal)
            secondSeatBool = true
            
        } else {
            middleLeftSeat.setImage(#imageLiteral(resourceName: "Unclicked-Passenger"), for: .normal)
            secondSeatBool = false
        }
    }
    @IBAction func thirdSeatClicked(_ sender: Any) {
        if (thirdSeatBool == false){
            middleMiddleSeat.setImage(#imageLiteral(resourceName: "Clicked-Passenger"), for: .normal)
            thirdSeatBool = true
            
        } else {
            middleMiddleSeat.setImage(#imageLiteral(resourceName: "Unclicked-Passenger"), for: .normal)
            thirdSeatBool = false
        }
    }
    
    @IBAction func fourthSeatClicked(_ sender: Any) {
        if (fourthSeatBool == false){
            middleRightSeat.setImage(#imageLiteral(resourceName: "Clicked-Passenger"), for: .normal)
            fourthSeatBool = true
            
        } else {
            middleRightSeat.setImage(#imageLiteral(resourceName: "Unclicked-Passenger"), for: .normal)
            fourthSeatBool = false
        }
    }
    
    
    @IBAction func fifthSeatClicked(_ sender: Any) {
        if (fifthSeatBool == false){
            backLeftSeat.setImage(#imageLiteral(resourceName: "Clicked-Passenger"), for: .normal)
            fifthSeatBool = true
            
        } else {
            backLeftSeat.setImage(#imageLiteral(resourceName: "Unclicked-Passenger"), for: .normal)
            fifthSeatBool = false
        }
    }
    
    @IBAction func sixthSeatClicked(_ sender: Any) {
        if (sixthSeatBool == false){
            backMiddleSeat.setImage(#imageLiteral(resourceName: "Clicked-Passenger"), for: .normal)
            sixthSeatBool = true
            
        } else {
            backMiddleSeat.setImage(#imageLiteral(resourceName: "Unclicked-Passenger"), for: .normal)
            sixthSeatBool = false
        }
    }
    @IBAction func seventhSeatClicked(_ sender: Any) {
        if (seventhSeatBool == false){
            backRightSeat.setImage(#imageLiteral(resourceName: "Clicked-Passenger"), for: .normal)
            seventhSeatBool = true
            
        } else {
            backRightSeat.setImage(#imageLiteral(resourceName: "Unclicked-Passenger"), for: .normal)
            seventhSeatBool = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func noDestButton(_ sender: Any) {
        if (destinationCheckBool == false) {
            self.noPlaceButton.setImage(#imageLiteral(resourceName: "Checked-Checkbox"), for: .normal)
            locationTextField.isUserInteractionEnabled = false
            locationTextField.text = ""
            locationTextField.backgroundColor = UIColor(red: 207/255, green: 223/255, blue: 229/255, alpha: 1)
            locationTextField.placeholder = "Disabled"
            destinationCheckBool = true
        } else {
            self.noPlaceButton.setImage(#imageLiteral(resourceName: "Unchecked-Box"), for: .normal)
            locationTextField.isUserInteractionEnabled = true
            locationTextField.placeholder = "Enter location here"
            locationTextField.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            destinationCheckBool = false
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        priceInput.resignFirstResponder()
    }


}
