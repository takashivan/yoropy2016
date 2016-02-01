//
//  HomeViewController.swift
//  practice
//
//  Created by 株式会社ConU on 2016/01/21.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//

import UIKit
import Parse
import BubbleTransition

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var userNameLabel: UILabel!

  
    @IBOutlet weak var eventTableView: UITableView!
   
    
    @IBAction func logOutAction(sender: AnyObject){
        
        // Send a request to log out a user
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! UIViewController
            self.presentViewController(viewController, animated: true, completion: nil)
        })
        
    }
    

    
    
    var eventDataArray: NSMutableArray = NSMutableArray()
    
    let tableViewHeight: CGFloat = 250.0
    
    let sectionCount: Int = 1
    
    override func viewDidAppear(animated: Bool) {
        self.loadParseData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.userNameLabel.text = "@" + pUserName
        }
        
        //テーブルビューのデリゲート
        self.eventTableView.delegate = self
        self.eventTableView.dataSource = self
        
        let nib:UINib = UINib(nibName: "DisplayCell", bundle: nil)
        self.eventTableView.registerNib(nib, forCellReuseIdentifier: "DisplayCell")
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    
    
    //要素数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //取得データの総数
        if self.eventDataArray.count > 0 {
            return self.eventDataArray.count
        } else {
            return 0
        }
    }
    
    //セクション数
    func numberOfsectionsInTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return self.sectionCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("DisplayCell") as? DisplayCell
        let event :AnyObject = self.eventDataArray.objectAtIndex(indexPath.row)
        
        let img: PFFile = (event.valueForKey("photo") as! PFFile)
        
            img.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    let croppedImg = CGImageCreateWithImageInRect(image?.CGImage, CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
                    cell!.eventImageView.image = image
                }
        }
        cell!.eventName.text = event.valueForKey("title") as? String
        cell!.username.text = event.valueForKey("user") as? String
        cell!.eventPlace.text = event.valueForKey("place") as? String
        cell!.eventDate.text = event.valueForKey("date") as? String
        
        cell!.selectionStyle = .None
        cell!.accessoryType = .None
        return cell!
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    self.viewDidLoad()
    }
    

    
    
    
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBOutlet weak var transitionButton: UIButton!
    
    let transition = BubbleTransition()
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let eventDetailData: AnyObject = self.eventDataArray.objectAtIndex(indexPath.row)
        performSegueWithIdentifier("detail", sender: eventDetailData)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detail" {
            let detailController = segue.destinationViewController as! DetailViewController
            detailController.eventDetailData = sender
        } else {
        let controller = segue.destinationViewController
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .Custom
        }
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = transitionButton.center
        transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = transitionButton.center
        transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
    
    
   
    
    
    func loadParseData() {
        self.eventDataArray.removeAllObjects()
        
        let query:PFQuery = PFQuery(className: "Event")
        
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error:NSError?) -> Void in
            
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        self.eventDataArray.addObject(object)
                    }
                    self.eventTableView.reloadData()
                }
            } else {
                
             print("ERROR")
            }
        }
    }
    
    
    

    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

