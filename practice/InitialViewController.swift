//
//  ViewController.swift
//  practice
//
//  Created by 株式会社ConU on 2016/01/21.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//

//
//  ViewController.swift
//  SBLoader
//
//  Created by Satraj Bambra on 2015-03-16.
//  Copyright (c) 2015 Satraj Bambra. All rights reserved.
//

import UIKit
import ChameleonFramework

class InitialViewController: UIViewController, HolderViewDelegate {
    
    var holderView = HolderView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSTimer.scheduledTimerWithTimeInterval(4.0,target:self,selector:Selector("transition"), userInfo: nil, repeats: false)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        addHolderView()
        holderView.addOval()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addHolderView() {
        let boxSize: CGFloat = 100.0
        holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
            y: view.bounds.height / 2 - boxSize / 2,
            width: boxSize,
            height: boxSize)
        holderView.parentFrame = view.frame
        holderView.delegate = self
        view.addSubview(holderView)
    }
    
    func animateLabel() {
        // 1
        holderView.removeFromSuperview()
        view.backgroundColor = UIColor.flatMintColor()
        
        // 2
        var label: UILabel = UILabel(frame: view.frame)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 170.0)
        label.textAlignment = NSTextAlignment.Center
        label.text = "Yoropy"
        label.font = UIFont(name: "Amable", size: 75)
        label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25)
        view.addSubview(label)
        
        // 3
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut,
            animations: ({
                label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0)
            }), completion: { finished in
                self.addButton()
        })
        
    }
    
    func addButton() {
        let button = UIButton()
        button.frame = CGRectMake(0.0, 0.0, view.bounds.width, view.bounds.height)
        button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }
    
    func buttonPressed(sender: UIButton!) {
        view.backgroundColor = UIColor.whiteColor()
        view.subviews.map({ $0.removeFromSuperview() })
        holderView = HolderView(frame: CGRectZero)
        addHolderView()
    }
    
    func transition() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let next:UIViewController = storyboard.instantiateViewControllerWithIdentifier("Home") as UIViewController
        
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        self.presentViewController(next, animated: true, completion: nil)
    }
    

    
}



