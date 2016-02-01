//
//  AddDatePopController.swift
//  practice
//
//  Created by 株式会社ConU on 2016/02/01.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//

import UIKit



var dateList = [String]()

class AddDatePopViewController: UIViewController, UITextFieldDelegate {
    
    let dateField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.flatWhiteColor()
        self.view.alpha = 0.5
        
        let label = UILabel()
        label.text = "ADD DATE & TIME"
        label.textAlignment = .Center
        label.textColor = UIColor.flatBlueColorDark()
        label.font = UIFont(name: "Arcon", size: 26)
        label.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height/12)
        label.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(label)
        
        
        dateField.backgroundColor = UIColor.whiteColor()
        dateField.layer.borderColor = UIColor.flatBlueColor().CGColor
        dateField.placeholder = "  DATE"
        dateField.frame = CGRectMake(15, label.frame.height+10 , self.view.frame.width-50, 50)
        dateField.layer.borderWidth = 1
        dateField.layer.cornerRadius = 10
        dateField.textAlignment = .Left
        dateField.font = UIFont(name: "Arcon", size: 24)
        self.view.addSubview(dateField)
        
        
        
        // create the detail label
        
        
        
        
        dateField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: UIButton) {
        
        
        dateList.append(dateField.text!)
        dateField.text = ""
        NSUserDefaults.standardUserDefaults().setObject(dateList, forKey: "date")
    
        
        
        let parentVC = presentingViewController as! AddDateViewController
        parentVC.dateTableView.reloadData()
        
        
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        dateField.resignFirstResponder()
       
        return true
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

