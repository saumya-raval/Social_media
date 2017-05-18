//
//  Post.swift
//  
//
//  Created by Saumya Raval on 5/17/17.
//
//

import Foundation

class Post {
    
    private var _caption: String!
    private var _likes: Int!
    private var _imageURL: String!
    private var _postID: String!
    
    var caption: String {
        return _caption
    }
    
    var likes: Int {
        return _likes
    }
    
    var imageURL: String {
        return _imageURL
    }
    
    var postID: String {
        return _postID
    }
    
    init(caption: String, likes: Int, imageURL: String) {
        self._caption = caption
        self._likes = likes
        self._imageURL = imageURL
    }
    
    init(postID: String, postDict: Dictionary<String, AnyObject>) {
        self._postID = postID
        self._caption = postDict["caption"] as? String
        self._imageURL = postDict["imageURL"] as? String
        self._likes = postDict["likes"] as? Int
    }

}
