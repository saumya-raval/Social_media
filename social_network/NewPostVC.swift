//
//  NewPostVC.swift
//  social_network
//
//  Created by Saumya Raval on 5/31/17.
//  Copyright © 2017 ImbaGames. All rights reserved.
//

import UIKit
import Firebase

class NewPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var addImage: RoundEdgeBtn!
    @IBOutlet weak var captionField: CustomTextField!
    
    var imagePicker: UIImagePickerController!
    var imageAdded: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.setImage(image, for: .normal)
            imageAdded = true
        } else {
            print("SAUMYA: Failed to select valid iamge")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func postToFirebase(imgURL: String, ID: String) {
        let post: Dictionary<String, AnyObject> = [
            "caption": captionField.text as AnyObject,
            "imageURL": imgURL as AnyObject,
            "likes": 0 as AnyObject
        ]
        print(ID)
        let firebasePost = DataServices.ds.REF_POSTS.child(ID)
        firebasePost.setValue(post)
        
        captionField.text = ""
        imageAdded = false
        addImage.setImage(#imageLiteral(resourceName: "icon-camera-128"), for: .normal)
    }
    
    @IBAction func cameraBtnClicked(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postBtnClicked(_ sender: Any) {
        guard let caption = captionField.text, caption != "" else {
            print("SAUMYA: Cannot leave caption empty")
            return
        }
        guard imageAdded == true else {
            print("SAUMYA: Need an image")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(addImage.currentImage!, 0.2) {
            // Int(Date().timeIntervalSince1970 * 1000)
            let postID: String = "\(Int(Date().timeIntervalSince1970))"
            print(postID)
            let imgMetaData = FIRStorageMetadata()
            imgMetaData.contentType = "image/jpeg"
            
            DataServices.ds.REF_PICS.child(postID).put(imgData, metadata: imgMetaData, completion: { (metadata, error) in
                if error != nil {
                    print("SAUMYA: Failed to upload image")
                } else {
                    print("SAUMYA: Image uploaded successfully!!!")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        self.postToFirebase(imgURL: url, ID: postID)
                    }
                }
            })
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func cancelClicked(_ sender: Any) {
        performSegue(withIdentifier: "PostVCToFeedVC", sender: nil)
    }

}
