//
//  TutorPostingsViewController.swift
//  SwiftExample
//
//  Created by Ryan Lehman on 7/25/17.
//  Copyright © 2017 Charcoal Design. All rights reserved.
//

import UIKit
import paper_onboarding
import Firebase

class TutorPostingsViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var noDatesSelectedText: UILabel!

    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var enterATimeLabel: UILabel!
    @IBOutlet weak var alarmClockImage: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var dollarLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var dollarImage: UIImageView!
    @IBOutlet weak var priceInput: UITextField!
    @IBOutlet weak var calednarImage: UIImageView!
    var mondayBoolean = false
    var tuesdayBoolean = false
    var wednesdayBoolean = false
    var thursdayBoolean = false
    var fridayBoolean = false
    var saturdayBoolean = false
    var sundayBoolean = false
    var ref: DatabaseReference!
    
    var dayCounter = 0
    @IBOutlet weak var mondayButton2: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    var weekdayArray = ["fMonday", "fTuesday", "fWednesday", "fThursday", "fFriday", "fSaturday", "fSunday"]
    var newList = [String]()
    var noDaysBoolean = false
    var finalDictionary = [String: String]()
    @IBOutlet weak var tutorPostView: TutorsPost!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newList.removeAll(keepingCapacity: true)
        for i in 0 ... (weekdayArray.count - 1) {
            let index = weekdayArray[i].index(weekdayArray[i].startIndex, offsetBy: 1)
            let letter = weekdayArray[i].substring(to: index)
            if (letter == "t") {
                newList.append(weekdayArray[i].substring(from: index))
                
            } else {
                print("Nothing")
            }
            
        }
        if (newList.count == 0) {
            noDaysBoolean = false
        } else {
            noDaysBoolean = true
        }
        return newList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TutorTimeCollectionViewCell
        cell.startDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
        cell.endDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
        cell.weekdayLabel.text = newList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TutorTimeCollectionViewCell
        
        let startTime = cell.startDatePicker
        let endTime = cell.endDatePicker
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let startStringTime = dateFormatter.string(from: (startTime!.date))
        let endStringTime = dateFormatter.string(from: (endTime!.date))
        
        print(startStringTime)
        print(endStringTime)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let runtime = timeCollectionView.visibleCells
        
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        self.priceInput.delegate = self;
        noDatesSelectedText.layer.borderColor = UIColor.white.cgColor
        submitButton.layer.borderColor = UIColor.white.cgColor
        mondayButton2.layer.borderColor = UIColor.white.cgColor
        tuesdayButton.layer.borderColor = UIColor.white.cgColor
        wednesdayButton.layer.borderColor = UIColor.white.cgColor
        thursdayButton.layer.borderColor = UIColor.white.cgColor
        fridayButton.layer.borderColor = UIColor.white.cgColor
        saturdayButton.layer.borderColor = UIColor.white.cgColor
        sundayButton.layer.borderColor = UIColor.white.cgColor
        
        tutorPostView.dataSource = self
        tutorPostView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        priceInput.resignFirstResponder()
    }
    
    func onboardingItemsCount() -> Int {
        return 5
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor(red: 217/255, green: 72/255, blue: 89/255, alpha: 1)
        let backgroundColorTwo = UIColor(red: 106/255, green: 166/255, blue: 211/255, alpha: 1)
        let backgroundColorThree = UIColor(red: 106/255, green: 221/255, blue: 211/255, alpha: 1)
        let backgroundColorFour = UIColor(red: 168/255, green: 200/255, blue: 78/255, alpha: 1)
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont2 = UIFont(name: "AvenirNext-Regular", size: 18)!
      
        
        return[(imageName: #imageLiteral(resourceName: "fake"), title: "", description: "", iconName: #imageLiteral(resourceName: "fake"), color: backgroundColorTwo, titleColor: UIColor.red, descriptionColor: UIColor.red, titleFont: titleFont, descriptionFont: descriptionFont2),
               
               (imageName: #imageLiteral(resourceName: "Calendar"), title: "Pick A Schedule", description: "Pick a schedule that works best for you. Avaliable times should at least be 1 hour", iconName: #imageLiteral(resourceName: "fake"), color: backgroundColorOne, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont2),
               
               (imageName: #imageLiteral(resourceName: "fake"), title: "", description: "", iconName: #imageLiteral(resourceName: "fake"), color: backgroundColorTwo, titleColor: UIColor.red, descriptionColor: UIColor.red, titleFont: titleFont, descriptionFont: descriptionFont2),
               
               (imageName: #imageLiteral(resourceName: "fake"), title: "", description: "", iconName: #imageLiteral(resourceName: "fake"), color: backgroundColorThree, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont2),
               
               (imageName: #imageLiteral(resourceName: "fake"), title: "", description: "", iconName: #imageLiteral(resourceName: "fake"), color: backgroundColorFour, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont2)][index]
        
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        //
    }
    
    
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            UIView.animate(withDuration: 0.4, animations: {
                self.mondayButton2.alpha = 1
                self.tuesdayButton.alpha = 1
                self.wednesdayButton.alpha = 1
                self.thursdayButton.alpha = 1
                self.fridayButton.alpha = 1
                self.saturdayButton.alpha = 1
                self.sundayButton.alpha = 1
                self.calednarImage.alpha = 1
                
            })
        }
        if index == 4 {
            UIView.animate(withDuration: 0.4, animations: {
                self.priceInput.alpha = 1
                self.dollarImage.alpha = 1
                self.lineLabel.alpha = 1
                self.priceText.alpha = 1
                self.dollarLabel.alpha = 1
                self.submitButton.alpha = 1
                
            })
        }
        if index == 3 {
            UIView.animate(withDuration: 0.4, animations: {
                self.alarmClockImage.alpha = 1
                self.enterATimeLabel.alpha = 1
                if (self.noDaysBoolean == true) {
                    self.timeCollectionView.alpha = 1
                } else {
                    self.noDatesSelectedText.alpha = 1
                }
                
            })
        }
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if (index == 1 || index == 0 || index == 3 || index == 4) {
            
            if self.mondayButton2.alpha == 1 {
                
                UIView.animate(withDuration: 0.2, animations: {
                    
                    self.mondayButton2.alpha = 0
                    self.tuesdayButton.alpha = 0
                    self.wednesdayButton.alpha = 0
                    self.thursdayButton.alpha = 0
                    self.fridayButton.alpha = 0
                    self.saturdayButton.alpha = 0
                    self.sundayButton.alpha = 0
                    self.calednarImage.alpha = 0
                })
            }
            
        }
        
        if (index == 0 || index == 1 || index == 2 || index == 4) {
            
            if self.alarmClockImage.alpha == 1 {
                
                UIView.animate(withDuration: 0.2, animations: {
                    
                    self.alarmClockImage.alpha = 0
                    self.enterATimeLabel.alpha = 0
                    self.timeCollectionView.alpha = 0
                    self.noDatesSelectedText.alpha = 0
                })
            }
            
        }
        
        if (index == 0 || index == 1 || index == 2 || index == 3) {
            
            if self.priceInput.alpha == 1 {
                
                UIView.animate(withDuration: 0.2, animations: {
                    
                    self.priceInput.alpha = 0
                    self.dollarImage.alpha = 0
                    self.lineLabel.alpha = 0
                    self.priceText.alpha = 0
                    self.dollarLabel.alpha = 0
                    self.submitButton.alpha = 0
                })
            }
            
        }

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
    
    
    
    @IBAction func mondayClicked2(_ sender: Any) {
        if (mondayBoolean == false){
            mondayButton2.backgroundColor = UIColor.white
            mondayButton2.setTitleColor(UIColor.black, for: .normal)
            weekdayArray[0] = "tMonday"
            finalDictionary["Monday"] = ""
            dayCounter += 1
            self.timeCollectionView.reloadData()
            mondayBoolean = true
            
        } else {
            mondayButton2.backgroundColor = UIColor.clear
            mondayButton2.setTitleColor(UIColor.white, for: .normal)
            weekdayArray[0] = "fMonday"
            finalDictionary.removeValue(forKey: "Monday")
            
            dayCounter -= 1
            self.timeCollectionView.reloadData()
            mondayBoolean = false
            
        }
        
    }
    @IBAction func tuesdayClicked(_ sender: Any) {
        if (tuesdayBoolean == false){
            tuesdayButton.backgroundColor = UIColor.white
            tuesdayButton.setTitleColor(UIColor.black, for: .normal)
            weekdayArray[1] = "tTuesday"
            finalDictionary["Tuesday"] = ""
            dayCounter += 1
            self.timeCollectionView.reloadData()
            tuesdayBoolean = true
        } else {
            tuesdayButton.backgroundColor = UIColor.clear
            tuesdayButton.setTitleColor(UIColor.white, for: .normal)
            weekdayArray[1] = "fTuesday"
            finalDictionary.removeValue(forKey: "Tuesday")
            dayCounter -= 1
            self.timeCollectionView.reloadData()
            tuesdayBoolean = false
        }
    }
    @IBAction func wednesdayClicked(_ sender: Any) {
        if (wednesdayBoolean == false){
            wednesdayButton.backgroundColor = UIColor.white
            wednesdayButton.setTitleColor(UIColor.black, for: .normal)
            weekdayArray[2] = "tWednesday"
            finalDictionary["Wednesday"] = ""
            dayCounter += 1
            self.timeCollectionView.reloadData()
            wednesdayBoolean = true
        } else {
            wednesdayButton.backgroundColor = UIColor.clear
            wednesdayButton.setTitleColor(UIColor.white, for: .normal)
            weekdayArray[2] = "fWednesday"
            finalDictionary.removeValue(forKey: "Wednesday")
            dayCounter -= 1
            self.timeCollectionView.reloadData()
            wednesdayBoolean = false
        }
    }
    @IBAction func thursdayClicked(_ sender: Any) {
        if (thursdayBoolean == false){
            thursdayButton.backgroundColor = UIColor.white
            thursdayButton.setTitleColor(UIColor.black, for: .normal)
            weekdayArray[3] = "tThursday"
            finalDictionary["Thursday"] = ""
            dayCounter += 1
            self.timeCollectionView.reloadData()
            thursdayBoolean = true
        } else {
            thursdayButton.backgroundColor = UIColor.clear
            thursdayButton.setTitleColor(UIColor.white, for: .normal)
            weekdayArray[3] = "fThursday"
            finalDictionary.removeValue(forKey: "Thursday")
            dayCounter -= 1
            self.timeCollectionView.reloadData()
            thursdayBoolean = false
        }
    }
    @IBAction func fridayClicked(_ sender: Any) {
        if (fridayBoolean == false){
            fridayButton.backgroundColor = UIColor.white
            fridayButton.setTitleColor(UIColor.black, for: .normal)
            weekdayArray[4] = "tFriday"
            finalDictionary["Friday"] = ""
            dayCounter += 1
            self.timeCollectionView.reloadData()
            fridayBoolean = true
        } else {
            fridayButton.backgroundColor = UIColor.clear
            fridayButton.setTitleColor(UIColor.white, for: .normal)
            weekdayArray[4] = "fFriday"
            finalDictionary.removeValue(forKey: "Friday")
            dayCounter -= 1
            self.timeCollectionView.reloadData()
            fridayBoolean = false
        }
    }
    @IBAction func saturdayClicked(_ sender: Any) {
        if (saturdayBoolean == false){
            saturdayButton.backgroundColor = UIColor.white
            saturdayButton.setTitleColor(UIColor.black, for: .normal)
            weekdayArray[5] = "tSaturday"
            finalDictionary["Saturday"] = ""
            dayCounter += 1
            self.timeCollectionView.reloadData()
            saturdayBoolean = true
        } else {
            saturdayButton.backgroundColor = UIColor.clear
            saturdayButton.setTitleColor(UIColor.white, for: .normal)
            weekdayArray[5] = "fSaturday"
            finalDictionary.removeValue(forKey: "Saturday")
            dayCounter -= 1
            self.timeCollectionView.reloadData()
            saturdayBoolean = false
        }
    }
    @IBAction func sundayClicked(_ sender: Any) {
        if (sundayBoolean == false){
            sundayButton.backgroundColor = UIColor.white
            sundayButton.setTitleColor(UIColor.black, for: .normal)
            weekdayArray[6] = "tSunday"
            finalDictionary["Sunday"] = ""
            dayCounter += 1
            self.timeCollectionView.reloadData()
            sundayBoolean = true
        } else {
            sundayButton.backgroundColor = UIColor.clear
            sundayButton.setTitleColor(UIColor.white, for: .normal)
            weekdayArray[6] = "tSunday"
            finalDictionary.removeValue(forKey: "Sunday")
            dayCounter -= 1
            self.timeCollectionView.reloadData()
            sundayBoolean = false
        }
        print(dayCounter)
    }
    
    @IBAction func clickedSubmitButton(_ sender: Any) {
        if priceInput.text != "" {
            if (mondayBoolean == false && tuesdayBoolean == false && wednesdayBoolean == false && thursdayBoolean == false && fridayBoolean == false && saturdayBoolean == false && sundayBoolean == false){
                let weekdayAlert = UIAlertController(title: "No Days Selected", message: "Please choose at least one day to tutor.", preferredStyle: UIAlertControllerStyle.alert)
                weekdayAlert.addAction(UIAlertAction(title: "👍", style: UIAlertActionStyle.default, handler: nil))
                self.present(weekdayAlert, animated: true, completion: nil)
            }else {
                
            }
        } else {
            let priceAlert = UIAlertController(title: "Invalid price", message: "Please enter a price per hour.", preferredStyle: UIAlertControllerStyle.alert)
            priceAlert.addAction(UIAlertAction(title: "👍", style: UIAlertActionStyle.default, handler: nil))
            self.present(priceAlert, animated: true, completion: nil)
            
        }
    }

}
