//
//  Car.swift
//  SixtApp
//
//  Created by Shabir Jan on 28/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import Foundation
import ObjectMapper

enum CarTransmissionType {
    static let manual = "Manual"
    static let automatic = "Automatic"
}

class Car: Mappable {
    var id  = ""
    var modelIdentifier  = ""
    var modelName  = ""
    var make = ""
    var color = ""
    var transmission = ""
    var latitude = 0.0
    var longitude = 0.0
    var innerCleanliness = ""
    var carImageUrl = ""
    var carTitle = ""
    required init?(map: Map) {

    }
    func mapping(map: Map) {
        id <- map["id"]
        modelIdentifier <- map ["modelIdentifier"]
        modelName <- map["modelName"]
        make <- map["make"]
        carTitle = make + "•" + modelName
        color <- map["color"]
        transmission  <- map["transmission"]
        transmission = "Transmission : \(transmission.lowercased() == "m" ? CarTransmissionType.manual : CarTransmissionType.automatic)"
        latitude   <- map["latitude"]
        longitude   <- map["longitude"]
        innerCleanliness  <- map["innerCleanliness"]
        carImageUrl = "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/\(modelIdentifier)/\(color)/2x/car.png"

    }
}
