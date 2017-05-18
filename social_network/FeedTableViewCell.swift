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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post, img: UIImage? = nil){
        self.post = post
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
        
    }

}
