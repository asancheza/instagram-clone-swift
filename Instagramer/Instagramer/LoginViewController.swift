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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(username.text!, password: password.text!) { (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil {
                print("You're logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
            } else {
                print(error!.localizedDescription)
            }
            
        }
    }

    @IBAction func onSignup(sender: AnyObject) {
        let newUser = PFUser()
        
        // set user properties
        newUser.username = username.text
        newUser.password = password.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User registered successfully")
                
                // manually segue to logged in view
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            
        }
    }
}
