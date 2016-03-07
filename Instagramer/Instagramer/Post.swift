//
//  Post.swift
//  Instagramer
//
//  Created by eMobc SL on 06/03/16.
//  Copyright © 2016 Neurowork. All rights reserved.
//

import UIKit
import Parse

let imageDataSetNotification = "imageDataSet";

class Post: NSObject {
    
    var username: PFUser?
    var usernameString: String?
    var caption: String?
    var image: UIImage?
    var numLikes: Int?
    var numComments: Int?
    
    var cell: TimelineTableViewCell?
    
    init(object: PFObject) {
        super.init()
        
        let newObject = object
        
        username = newObject["author"] as? PFUser
        caption = newObject["caption"] as? String
        numLikes = newObject["likesCount"] as? Int
        numComments = newObject["commentsCount"] as? Int
        usernameString = username?.username!
        
        if let newImage = object.valueForKey("media")! as? PFFile {
            
            newImage.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    print("Image data found.. saving UIImage")
                    let image = UIImage(data: imageData!)
                    print(image)
                    self.image = image
                    self.cell?.post = self;
                    NSNotificationCenter.defaultCenter().postNotificationName(imageDataSetNotification, object: nil)
                } else {
                    print("ERROR: could not get image \(error?.localizedDescription)")
                }
                }, progressBlock: { (int: Int32) -> Void in
                    print("int yay!")
            })
        }
    }
    
    class func postUserImage(image: UIImage?, caption: String?, completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Post")
        
        post["media"] = getPFFileFromImage(image)
        post["author"] = PFUser.currentUser()
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        post.saveInBackgroundWithBlock(completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    class func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}