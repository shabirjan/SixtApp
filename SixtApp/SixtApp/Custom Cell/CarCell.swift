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

    @IBOutlet weak var carImg: UIImageView!
    @IBOutlet weak var lblCleaniness: UILabel!
    @IBOutlet weak var lblTransmission: UILabel!
    @IBOutlet weak var lblCarName: UILabel!
    
    
    //MARK: -Overriding method to set cell selectionstyle to .none
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    //MARK: -Method responsible for returning height for each cell
    static func height() -> CGFloat {
        return 110
    }
    
    //MARK: -Method responsible for setting values in the Cell 
    func configureWithCar(car: Car) {
        lblCarName.text = car.carTitle
        lblTransmission.text = car.transmission
        lblCleaniness.text   = car.innerCleanliness
        carImg.download(image: car.carImageUrl)
    }
}
