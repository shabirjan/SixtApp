//
//  CarCell.swift
//  SixtApp
//
//  Created by Shabir Jan on 01/03/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {

    
    static let Identifier = "CarCell"
    @IBOutlet weak var carImg: UIImageView!
    @IBOutlet weak var lblCleaniness: UILabel!
    @IBOutlet weak var lblTransmission: UILabel!
    @IBOutlet weak var lblCarName: UILabel!
    
    func configureWithCar(car: Car) {
        lblCarName.text = car.make + "•" + car.modelName
        lblTransmission.text = "Transmission : \( car.transmission.lowercased() == "m" ? CarTransmissionType.manual : CarTransmissionType.automatic)"
        lblCleaniness.text   = "Cleanliness  : \(car.innerCleanliness)"
        carImg.download(image: car.carImageUrl)
    }
    


}
