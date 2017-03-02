//
//  UIImageView+Kingfisher.swift
//  DaleniApp
//
//  Created by Shabir Jan on 24/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView{
    func download(image url : String) {
        guard let imageURL = URL(string:url) else {
            return
        }
        self.kf.indicatorType = .activity
        let image = UIImage(named: "car-placeholder")
        self.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: image)
    }
}
