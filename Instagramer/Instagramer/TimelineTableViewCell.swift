//
//  TimelineTableViewCell.swift
//  Instagramer
//
//  Created by eMobc SL on 06/03/16.
//  Copyright © 2016 Neurowork. All rights reserved.
//

import UIKit
import Parse

class TimelineTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userCaptionUsername: UILabel!
    @IBOutlet weak var userCaptionTextView: UITextView!
    
    var object: PFObject? {
        didSet {
            post = Post(object: object!)
            post.cell = self;
        }
    }
    
    var post: Post! {
        didSet {
            usernameLabel.text = post.usernameString
            userCaptionUsername.text = post.usernameString
            userImageView.image = post.image
            userCaptionTextView.text = post.caption
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}