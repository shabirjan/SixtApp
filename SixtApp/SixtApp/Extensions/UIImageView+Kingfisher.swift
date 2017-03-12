//
//  UIImageView+Kingfisher.swift
//  SixtApp  
//
//  Created by Shabir Jan on 24/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import UIKit
import SDWebImage
extension UIImageView{
    
    //MARK: -Method responsible for downloading and setting image in the imageview
    func download(image url : String) {
        guard let imageURL = URL(string:url) else {
            return
        }
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "car-placeholder"))
    }
}
