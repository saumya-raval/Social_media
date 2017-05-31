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
import Foundation

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        DataServices.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            self.posts = []
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postID: key, postDict: postDict)
                        self.posts.insert(post, at: 0)
                    }
                }
            }
            self.tableView.reloadData()
        })
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
            } else {
                cell.configureCell(post: post)
            }
            return cell
        } else {
            return FeedTableViewCell()
        }
        
    }
    
    @IBAction func newPostTapped(_ sender: Any) {
        performSegue(withIdentifier: "NewPostVC", sender: nil)
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
    
}
