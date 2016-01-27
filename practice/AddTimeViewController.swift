//
//  SelectTimeViewController.swift
//  practice
//
//  Created by 株式会社ConU on 2016/01/22.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//


import UIKit



class AddTimeViewController: UIViewController,UITableViewDelegate, UITextFieldDelegate {
    var todoItem = [String]()
        
        @IBOutlet weak var todolistTable: UITableView!
        
        @IBOutlet weak var itemText: UITextField!
        
        @IBAction func addItem(sender: AnyObject) {
            todoItem.append(itemText.text!)
            itemText.text = ""
            NSUserDefaults.standardUserDefaults().setObject(todoItem, forKey: "todoList")
            todolistTable.reloadData()
        }
        
        @IBAction func tapScreen(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            if NSUserDefaults.standardUserDefaults().objectForKey("todoList") != nil {
                todoItem = NSUserDefaults.standardUserDefaults().objectForKey("todoList") as! [String]
            }
            itemText.delegate = self
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return todoItem.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cellValue = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            cellValue .textLabel?.text = todoItem[indexPath.row]
            return cellValue
        }
        
        
        func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
            if editingStyle == UITableViewCellEditingStyle.Delete{
                todoItem.removeAtIndex(indexPath.row)
                NSUserDefaults.standardUserDefaults().setObject(todoItem, forKey: "todoList")
                todolistTable.reloadData()
            }
        }
        
        override func viewDidAppear(animated: Bool) {
            todolistTable.reloadData()
        }
        
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            itemText.resignFirstResponder()
            return true
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
}

