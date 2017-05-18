//
//  FeedTableViewCell.swift
//  social_network
//
//  Created by Saumya Raval on 5/16/17.
//  Copyright © 2017 ImbaGames. All rights reserved.
//

import UIKit

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
    
    func configureCell(post: Post){
        self.post = post
        self.postCellCaption.text = post.caption
        self.likesCount.text = "\(post.likes)"
    }

}
