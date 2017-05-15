//
//  ImageViewShadow.swift
//  social_network
//
//  Created by Saumya Raval on 5/15/17.
//  Copyright © 2017 ImbaGames. All rights reserved.
//

import UIKit

class ImageViewShadow: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

}
