//
//  PopOverViewController.swift
//  TestPopOverView
//
//  Created by Suryakant Sharma on 28/08/15.
//  Copyright (c) 2015 WAH Holidays Pvt. Ltd. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - IBAction
    
    @IBAction func googleButtonClicked(sender : UIButton){
        
            }
    
    @IBAction func addButtonClicked(sender : UIButton){
        NSLog("shareButtonClicked")
        self.dismissViewControllerAnimated(true, completion: nil)
    }



}
