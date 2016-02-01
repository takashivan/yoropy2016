//
//  InfoPopupMasterView.swift
//  NewLinQ
//
//  Created by Martijn de Vos on 25-12-14.
//  Copyright (c) 2014 YourConnector. All rights reserved.
//

import Foundation
import UIKit

enum CloseButtonPosition
{
    case Left, Right
}

class MVPopupView : UIView
{
    var popupView: UIView?
    var closeButton: UIButton?
    var googleButton: UIButton?
    var offsetY: CGFloat = 0.0
    
    init(frame: CGRect, contentView: UIView, offsetY: CGFloat)
    {
        super.init(frame: frame)
        
        let blurEffect = UIBlurEffect(style: .Dark)
        
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        visualEffectView.frame = self.frame
        
        let blur = UIView()
        blur.addSubview(visualEffectView)
        self.addSubview(blur)
        
        
        self.backgroundColor = UIColor.clearColor()
        
        let offsetX = UIScreen.mainScreen().bounds.width / 2 - contentView.frame.size.width / 2
        self.offsetY = offsetY
        
        popupView = UIView(frame: CGRectMake(offsetX, offsetY, contentView.frame.size.width, contentView.frame.size.height))
        popupView?.backgroundColor = UIColor.whiteColor()
        popupView?.layer.cornerRadius = 8.0
        popupView?.clipsToBounds = true
        self.addSubview(popupView!)
        
        popupView?.addSubview(contentView)
        
        // add close button
        createCloseButton()
        createGoogleButton()
    }
    
    func createCloseButton()
    {
        let offsetX = UIScreen.mainScreen().bounds.width / 2 - popupView!.frame.size.width / 2
        
        closeButton = UIButton(type: UIButtonType.System) as? UIButton
        closeButton?.frame = CGRectMake(offsetX, offsetY+500, 300, 40)
        closeButton?.backgroundColor = UIColor(red: 158.0/255.0, green: 140.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        closeButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        closeButton?.setTitle("×", forState: .Normal)
        closeButton?.titleLabel?.font = UIFont.boldSystemFontOfSize(25)
        closeButton?.addTarget(self, action: "closeButtonPressed:", forControlEvents: .TouchUpInside)
        self.insertSubview(closeButton!, aboveSubview: popupView!)
    }
    
    
    func createGoogleButton()
    {
        
        let offsetX = UIScreen.mainScreen().bounds.width / 2 - popupView!.frame.size.width / 2
        
        googleButton = UIButton(type: UIButtonType.System) as? UIButton
        googleButton?.frame = CGRectMake(offsetX - 8, offsetY - 8, 26, 26)
        googleButton?.backgroundColor = UIColor(red: 158.0/255.0, green: 140.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        googleButton?.layer.cornerRadius = 13
        googleButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        googleButton?.setTitle("×", forState: .Normal)
        googleButton?.titleLabel?.font = UIFont.boldSystemFontOfSize(18)
        googleButton?.addTarget(self, action: "closeButtonPressed:", forControlEvents: .TouchUpInside)
        self.insertSubview(googleButton!, aboveSubview: popupView!)
        
    }
    
    func setCloseButtonColor(color: UIColor)
    {
        closeButton?.backgroundColor = color
    }
    
    func setPopupBackgroundColor(color: UIColor)
    {
        self.backgroundColor = color
    }
    
    func setPopupCornerRadius(radius: CGFloat)
    {
        popupView?.layer.cornerRadius = radius
    }
    
    func setCloseButtonCornerRadius(radius: CGFloat)
    {
        closeButton?.layer.cornerRadius = radius
    }
    
    func setCloseButtonPosition(position: CloseButtonPosition)
    {
        let offsetX = UIScreen.mainScreen().bounds.width / 2 - popupView!.frame.size.width / 2
        if position == .Left
        {
            closeButton?.frame = CGRectMake(offsetX - 8, offsetY - 8, 26, 26)
        }
        else if position == .Right
        {
            closeButton?.frame = CGRectMake(offsetX + popupView!.frame.size.width - 14, offsetY - 8, 26, 26)
        }
    }
    
    func closeButtonPressed(sender: UIButton)
    {
        self.removeFromSuperview()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}