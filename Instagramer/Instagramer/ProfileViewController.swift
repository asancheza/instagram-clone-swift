//
//  ProfileViewController.swift
//  Instagramer
//
//  Created by eMobc SL on 06/03/16.
//  Copyright © 2016 Neurowork. All rights reserved.
//

import UIKit
import Parse

let userDidLogoutNotification = "userDidLogoutNotification"

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        print("Logging out user: \(PFUser.currentUser()!.username!)")
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
}