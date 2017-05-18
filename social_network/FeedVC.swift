//
//  FeedVC.swift
//  social_network
//
//  Created by Saumya Raval on 5/2/17.
//  Copyright © 2017 ImbaGames. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var addImage: RoundEdgeBtn!
    @IBOutlet weak var captionField: CustomTextField!
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        DataServices.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postID: key, postDict: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.setImage(image, for: .normal)
        } else {
            print("SAUMYA: Failed to select valid iamge")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        //print("SAUMYA: \(post.caption)")
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as? FeedTableViewCell {
            
            if let img = FeedVC.imageCache.object(forKey: post.imageURL as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
        } else {
            return FeedTableViewCell()
        }
        
    }

    @IBAction func signOutTapped(_ sender: Any) {
        let result = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("SAUMYA: Keychain item removed succesfully \(result)")
        do {
            try FIRAuth.auth()?.signOut()
        } catch let error as NSError {
            print("\(error)")
        }
        performSegue(withIdentifier: "SignOut", sender: nil)
    }
    
    @IBAction func cameraBtnClicked(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postBtnClicked(_ sender: Any) {
    }
    


    
}
