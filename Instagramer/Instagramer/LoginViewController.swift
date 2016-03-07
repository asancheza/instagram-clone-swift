//
//  LoginViewController.swift
//  Instagramer
//
//  Created by eMobc SL on 01/03/16.
//  Copyright © 2016 Neurowork. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(username.text!, password: password.text!) { (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil {
                print("You're logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
            } else {
                print(error!.localizedDescription)
                self.error.text = error!.localizedDescription
            }
        }
    }

    @IBAction func onSignup(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = username.text
        newUser.password = password.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                self.error.text = error.localizedDescription
            } else {
                print("User registered successfully")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
    }
}