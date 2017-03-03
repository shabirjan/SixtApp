//
//  UIImageView+Kingfisher.swift
//  DaleniApp
//
//  Created by Shabir Jan on 24/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import UIKit
import SDWebImage
extension UIImageView{
    func download(image url : String) {
        guard let imageURL = URL(string:url) else {
            return
        }
        let placeholderImage = UIImage(named: "car-placeholder")
        self.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
    }
}
