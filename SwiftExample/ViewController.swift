//
//  ViewController.swift
//  SwiftExample
//
//  Created by Ryan Lehman on 30/07/2014.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {
    
    var items: [Int] = []
    var postCount = 0
    @IBOutlet var carousel: iCarousel!

    func getData() {
        Database.database().reference().child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict2 = snapshot.value as? [String: AnyObject] {
                
                self.postCount = dict2.count
                
            }
            //This prints 3
            print(self.postCount)
        })
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print(self.postCount)
        for i in 0 ... 99 {
            items.append(i)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        print(self.postCount)
        carousel.type = .cylinder
    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        
        
        return items.count
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        var itemView: UIImageView

        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
            //get a reference to the label in the recycled view
            label = itemView.viewWithTag(1) as! UILabel
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 400))
            itemView.image = UIImage(named: "page.png")
            itemView.layer.borderWidth = 10
            itemView.contentMode = .center

            label = UILabel(frame: itemView.bounds)
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.font = label.font.withSize(50)
            label.tag = 1
            itemView.addSubview(label)
        }

        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        label.text = "\(items[index])"

        return itemView
    }

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }

}

