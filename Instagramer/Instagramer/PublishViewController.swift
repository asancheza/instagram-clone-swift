//
//  PublishViewController.swift
//  Instagramer
//
//  Created by eMobc SL on 06/03/16.
//  Copyright © 2016 Neurowork. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var caption: String = ""
    @IBOutlet weak var captionView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    var newImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        //vc.sourceType = UIImagePickerControllerSourceType.Camera
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            newImage = editedImage
            photoImageView.image = newImage
        
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPostPic(sender: AnyObject) {
        let image = Post.resize(newImage, newSize: CGSize(width: 400, height: 400))
        
        caption = captionView.text! ?? ""
        
        Post.postUserImage(image, caption: caption) { (success: Bool, error: NSError?) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
