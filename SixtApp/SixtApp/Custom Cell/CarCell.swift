//
//  CarCell.swift
//  SixtApp
//
//  Created by Shabir Jan on 01/03/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import UIKit
import Reusable
class CarCell: UITableViewCell, NibReusable {

    
    static let Identifier = "CarCell"
    @IBOutlet weak var carImg: UIImageView!
    @IBOutlet weak var lblCleaniness: UILabel!
    @IBOutlet weak var lblTransmission: UILabel!
    @IBOutlet weak var lblCarName: UILabel!
    
    static func height() -> CGFloat {
        return 110
    }
    
    func configureWithCar(car: Car) {
        lblCarName.text = car.carTitle
        lblTransmission.text = car.transmission
        lblCleaniness.text   = "Cleanliness  : \(car.innerCleanliness)"
        carImg.download(image: car.carImageUrl)
    }
}
