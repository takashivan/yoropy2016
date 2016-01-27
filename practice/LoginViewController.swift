
//
//  LogInViewController.swift
//  practice
//
//  Created by 株式会社ConU on 2016/01/21.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    
    @IBAction func loginAction(sender: AnyObject) {
        
        var username = self.usernameField.text
        var password = self.passwordField.text
        
        // Validate the text fields
        if username?.characters.count < 5 {
            let alert = SCLAlertView()
            alert.showError("CHECK USERNAME", subTitle: "Username shoud be 5 or more")
            
        } else if password?.characters.count < 8 {
            let alert = SCLAlertView()
            alert.showError("CHECK PASSWORD", subTitle: "Password seems wrong")
            
        } else {
            // Run a spinner to show a task in progress
            var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // Send a request to login
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                
                if ((user) != nil) {
                    var alert = SCLAlertView()
                    alert.showSuccess("Logged in!", subTitle: "Welcome back!")
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! UIViewController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                } else {
                    var alert = SCLAlertView()
                    alert.showError("Went Wrong!", subTitle: "plz check your password/username")
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        usernameField.delegate = self
        passwordField.delegate = self

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true }
    
}
