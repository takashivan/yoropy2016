//
//  SignUpViewController.swift
//  practice
//
//  Created by 株式会社ConU on 2016/01/21.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        let finalEmail = email?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        //validation
        
        
        if username?.characters.count < 5 {
            let alert = SCLAlertView()
            alert.showError("TOO SHORT", subTitle: "must be greater than 8")
        }else if password?.characters.count < 8 {
            let alert = SCLAlertView()
            alert.showError("TOO SHORT", subTitle: "must be greater than 8")

        } else if email?.characters.count < 8 {
            let alert = SCLAlertView()
            alert.showError("TOO SHORT", subTitle: "must be greater than 8")
            
        } else {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = finalEmail
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                if ((error) != nil) {
                    let alert = UIAlertController(title: "dame", message: "damedame", preferredStyle: .Alert)
                } else {
                    let alert = UIAlertController(title: "dae", message: "DDD", preferredStyle: .Alert)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") 
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
            })
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        
        
        
        
        
        return true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

