//
//  FeedTableViewCell.swift
//  social_network
//
//  Created by Saumya Raval on 5/16/17.
//  Copyright © 2017 ImbaGames. All rights reserved.
//

import UIKit
import Firebase

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var postCellImg: UIImageView!
    @IBOutlet weak var postCellCaption: UITextView!
    @IBOutlet weak var likesCount: UILabel!
    
    var post: Post!
    var likesRef: FIRDatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled = true
    }
    
    func configureCell(post: Post, img: UIImage? = nil){
        self.post = post
        likesRef = DataServices.ds.REF_USER_CURRENT.child("likes").child(post.postID)
        self.postCellCaption.text = post.caption
        self.likesCount.text = "\(post.likes)"
        
        if img != nil {
            postCellImg.image = img
        } else {
            let imgRef = FIRStorage.storage().reference(forURL: post.imageURL)
            imgRef.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Error downloading the image")
                } else {
                    print("Successfully downloaded image from Firebase Storage")
                    
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postCellImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: (post.imageURL as NSString))
                        }
                    }
                }
            })
        }
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "empty-heart")
            } else {
                self.likeImg.image = UIImage(named: "filled-heart")
            }
        })

    }

    func likeTapped(sender: UITapGestureRecognizer) {
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addLikes: true)
                self.likesRef.setValue(true)
            } else {
                self.likeImg.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addLikes: false)
                self.likesRef.removeValue()
            }
        })
    }
}
