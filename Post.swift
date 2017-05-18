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
    
    var likes: String {
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
    
    init(postID: String, postData: dictionary<String, Anyobject>) {
        self._postID = postID
        self._caption = postData["caption"]
        self._imageURL = postData["imageURL"]
        self._likes = postData["likes"]
    }

}
