//
//  ViewController.swift
//  chat
//
//  Created by Shawn Zhu on 9/9/15.
//  Copyright (c) 2015 Shawn Zhu. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        errorLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignIn(sender: AnyObject) {
        let login = emailTextField.text
        let pass = passTextField.text
        PFUser.logInWithUsernameInBackground(login, password: pass) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.performSegueWithIdentifier("toChatViewSeque", sender: sender)
            } else {
                // The login failed. Check error to see why.
                if let error = error {
                    println("\(error)")
                }
            }
        }
    }

    @IBAction func onSignUp(sender: AnyObject) {
        var user = PFUser()

        user.username = emailTextField.text
        user.password = passTextField.text
        user.email = emailTextField.text
        // other fields can be set just like with PFObject
        user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                self.errorLabel.text = "\(errorString!)"
            } else {
                // Hooray! Let them use the app now.
                self.errorLabel.text = ""
                self.performSegueWithIdentifier("toChatViewSeque", sender: sender)
            }
        }
    }
}

