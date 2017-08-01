//
//  TextBookViewController.swift
//  SwiftExample
//
//  Created by Ryan Lehman on 8/1/17.
//  Copyright © 2017 Charcoal Design. All rights reserved.
//

import UIKit
import YangMingShan
import paper_onboarding

class TextBookViewController: UIViewController, YMSPhotoPickerViewControllerDelegate, PaperOnboardingDataSource, PaperOnboardingDelegate, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    var images: NSArray! = []
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textbookView: TextBookPost!
    
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    let cellIdentifier = "imageCellIdentifier"
    @IBOutlet weak var clickCameraLabel: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var enterInformationLabel: UILabel!
    @IBOutlet weak var textBookImage: UIImageView!
    @IBOutlet weak var textBookNameBox: UITextField!
    @IBOutlet weak var authorNameBox: UITextField!
    @IBOutlet weak var yearBox: UITextField!
    @IBOutlet weak var numberOfPhotosSelectionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        textBookNameBox.delegate = self
        authorNameBox.delegate = self
        yearBox.delegate = self
        textbookView.dataSource = self
        textbookView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(TextBookViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TextBookViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        if index == 0 {
            UIView.animate(withDuration: 0.4, animations: {
                self.authorNameBox.alpha = 1
                self.textBookNameBox.alpha = 1
                self.yearBox.alpha = 1
                self.textBookImage.alpha = 1
                self.authorLabel.alpha = 1
                self.nameLabel.alpha = 1
                self.yearLabel.alpha = 1
                self.enterInformationLabel.alpha = 1
                
            })
        }
        
        if index == 1 {
            UIView.animate(withDuration: 0.4, animations: {
                self.clickCameraLabel.alpha = 1
                self.cameraButton.alpha = 1
                
            })
        }
        
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        
        if (index == 1 || index == 2 || index == 3 || index == 4) {
            
            if self.textBookImage.alpha == 1 {
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.authorNameBox.alpha = 0
                    self.textBookNameBox.alpha = 0
                    self.yearBox.alpha = 0
                    self.textBookImage.alpha = 0
                    self.authorLabel.alpha = 0
                    self.nameLabel.alpha = 0
                    self.yearLabel.alpha = 0
                    self.enterInformationLabel.alpha = 0
                    
                })
            }
            
        }
        
        if (index == 0 || index == 2 || index == 3 || index == 4) {
            
            if self.clickCameraLabel.alpha == 1 {
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.clickCameraLabel.alpha = 0
                    self.cameraButton.alpha = 0
                    
                })
            }
            
        }
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //###########################################################################################
    
    @IBAction func presentPhotoPicker(_ sender: Any) {
        print("Hello 1")
        var new2 = segmentedController.titleForSegment(at: segmentedController.selectedSegmentIndex)
        if (new2?.characters.count)! > 0
            && UInt(new2!)! != 1 {
            let pickerViewController = YMSPhotoPickerViewController.init()
            
            pickerViewController.numberOfPhotoToSelect = UInt(new2!)!
            
            let customColor = UIColor.init(red:248.0/255.0, green:217.0/255.0, blue:44.0/255.0, alpha:1.0)
            
            pickerViewController.theme.titleLabelTextColor = UIColor.black
            pickerViewController.theme.navigationBarBackgroundColor = customColor
            pickerViewController.theme.tintColor = UIColor.black
            pickerViewController.theme.orderTintColor = customColor
            pickerViewController.theme.orderLabelTextColor = UIColor.black
            pickerViewController.theme.cameraVeilColor = customColor
            pickerViewController.theme.cameraIconColor = UIColor.white
            pickerViewController.theme.statusBarStyle = .default
            
            self.yms_presentCustomAlbumPhotoView(pickerViewController, delegate: self)
        }
        else {
            self.yms_presentAlbumPhotoView(with: self)
        }
    }
    

    func photoPickerViewControllerDidReceivePhotoAlbumAccessDenied(_ picker: YMSPhotoPickerViewController!) {
        print("Hello 2")
        let alertController = UIAlertController.init(title: "Allow photo album access?", message: "Need your permission to access photo albumbs", preferredStyle: .alert)
        let dismissAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction.init(title: "Settings", style: .default) { (action) in
            UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
        }
        alertController.addAction(dismissAction)
        alertController.addAction(settingsAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func photoPickerViewControllerDidReceiveCameraAccessDenied(_ picker: YMSPhotoPickerViewController!) {
        print("Hello 3")
        let alertController = UIAlertController.init(title: "Allow camera album access?", message: "Need your permission to take a photo", preferredStyle: .alert)
        let dismissAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction.init(title: "Settings", style: .default) { (action) in
            UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
        }
        alertController.addAction(dismissAction)
        alertController.addAction(settingsAction)
        
        // The access denied of camera is always happened on picker, present alert on it to follow the view hierarchy
        picker.present(alertController, animated: true, completion: nil)
    }
    
    func photoPickerViewController(_ picker: YMSPhotoPickerViewController!, didFinishPicking image: UIImage!) {
        print("Hello 4")
        picker.dismiss(animated: true) {
            self.images = [image]
            self.collectionView.reloadData()
            
        }
    }
    
    func photoPickerViewController(_ picker: YMSPhotoPickerViewController!, didFinishPickingImages photoAssets: [PHAsset]!) {
        print("Hello 5")
        picker.dismiss(animated: true) {
            let imageManager = PHImageManager.init()
            let options = PHImageRequestOptions.init()
            options.deliveryMode = .highQualityFormat
            options.resizeMode = .exact
            options.isSynchronous = true
            
            let mutableImages: NSMutableArray! = []
            
            for asset: PHAsset in photoAssets
            {
                let scale = UIScreen.main.scale
                let targetSize = CGSize(width: (self.collectionView.bounds.width - 20*2) * scale, height: (self.collectionView.bounds.height - 20*2) * scale)
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options, resultHandler: { (image, info) in
                    mutableImages.add(image!)
                })
            }
            
            self.images = mutableImages.copy() as? NSArray
            self.collectionView.reloadData()
            
        }
    }
    
    func deletePhotoImage(_ sender: UIButton!) {
        print("Hello 6")
        let mutableImages: NSMutableArray! = NSMutableArray.init(array: images)
        mutableImages.removeObject(at: sender.tag)
        
        self.images = NSArray.init(array: mutableImages)
        self.collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [IndexPath.init(item: sender.tag, section: 0)])
        }, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        authorNameBox.resignFirstResponder()
        yearBox.resignFirstResponder()
        textBookNameBox.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Hello 7")
        print(self.images.count)
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Hello 8")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCellIdentifier", for: indexPath) as! PhotoCollectionViewCell
        
        print("Hello 10")
        cell.photoImageView.image =  self.images.object(at: (indexPath as NSIndexPath).item) as? UIImage
        print("Hello 11")
        cell.deleteButton.tag = (indexPath as NSIndexPath).item
        cell.deleteButton.addTarget(self, action: #selector(TextBookViewController.deletePhotoImage(_:)), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    {
        print("Hello 9")
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

}
