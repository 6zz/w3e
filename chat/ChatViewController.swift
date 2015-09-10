//
//  ChatViewController.swift
//  chat
//
//  Created by Shawn Zhu on 9/9/15.
//  Copyright (c) 2015 Shawn Zhu. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var msgTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var msgs = [ParseMsg]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "refresh", userInfo: nil, repeats: true)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func j(sender: AnyObject) {
        var msg = PFObject(className:"Message")
        
        msg["text"] = msgTextField.text
        msg["user"] = PFUser.currentUser()
        msg.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                println("msg sent")
                self.msgTextField.text = ""
            } else {
                // There was a problem, check error.description
                if let error = error {
                    println("\(error)")
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MsgCell", forIndexPath: indexPath) as! MsgCell
        
        cell.msg = msgs[indexPath.row]
        
        return cell
    }
    
    func refresh() {
        var query = PFQuery(className:"Message")
        var msgs = [ParseMsg]()
//        query.whereKey("playerName", equalTo:"Sean Plott")
        query.orderByDescending("createdAt")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        msgs.append(ParseMsg(obj: object))
                    }
                }
                self.msgs = msgs
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
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
