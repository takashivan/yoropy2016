//
//  CellTableViewCell.swift
//  practice
//
//  Created by 株式会社ConU on 2016/01/26.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//

import UIKit

class DisplayCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var username: UILabel!
    
    
    @IBOutlet weak var alphaView: UIView!
    
    let button = DOFavoriteButton(frame: CGRectMake(0, 0, 70, 70), image: UIImage(named: "heart"))
    
    
    func tapped(sender: DOFavoriteButton) {
        if sender.selected {
            // deselect
            sender.deselect()
        } else {
            // select with animation
            sender.select()
        }
    }
    
    let date = UIImageView(image: UIImage(named: "date")?.imageWithRenderingMode(.AlwaysTemplate))
    
    let place = UIImageView(image: UIImage(named: "place")?.imageWithRenderingMode(.AlwaysTemplate))
    
    let eventPlace = UILabel()
    let eventDate = UILabel()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bringSubviewToFront(eventName)
        self.bringSubviewToFront(username)
        
        alphaView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.45)
        
        eventName.alpha = 1.0
        
        place.tintColor = UIColor.whiteColor()
        place.frame = CGRect(x: 15, y: 80, width: 30, height: 30)
        
        date.tintColor = UIColor.whiteColor()
        date.frame = CGRect(x: 15, y: 120, width: 30, height: 30)
        
        eventDate.frame = CGRect(x: 50, y: 120, width: 300, height: 30)
        eventDate.textColor = UIColor.whiteColor()
        
        eventPlace.frame = CGRect(x: 50, y: 80, width: 300, height: 30)
        eventPlace.textColor = UIColor.whiteColor()
        
        
        button.addTarget(self, action: Selector("tapped:"), forControlEvents: .TouchUpInside)
        
        button.imageColorOff = UIColor.whiteColor()
        button.imageColorOn = UIColor.flatRedColor()
        button.duration = 2.0 // default: 1.0
        
        button.frame = CGRect(x: 340, y: 170, width: 100, height: 100)
        
        
        self.addSubview(place)
        self.addSubview(date)
        self.addSubview(eventPlace)
        self.addSubview(eventDate)
        self.addSubview(button)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
