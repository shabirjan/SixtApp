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
    var name = ""
    var make = ""
    var group = ""
    var color = ""
    var series = ""
    var fuelType = ""
    var fuelLevel = 0.0
    var transmission = ""
    var licensePlate = ""
    var latitude = 0.0
    var longitude = 0.0
    var innerCleanliness = ""
    var carImageUrl = ""
    var carTitle = ""
    var carTransmission = ""
    required init?(map: Map) {

    }
    func mapping(map: Map) {
        id <- map["id"]
        modelIdentifier <- map ["modelIdentifier"]
        modelName <- map["modelName"]
        name <- map["name"]
        make <- map["make"]
        carTitle = make + "•" + modelName
        group <- map["group"]
        color <- map["color"]
        series <- map["series"]
        fuelType   <- map["fuelType"]
        fuelLevel  <- map["fuelLevel"]
        transmission  <- map["transmission"]
        carTransmission = "Transmission : \(transmission.lowercased() == "m" ? CarTransmissionType.manual : CarTransmissionType.automatic)"
        licensePlate   <- map["licensePlate"]
        latitude   <- map["latitude"]
        longitude   <- map["longitude"]
        innerCleanliness  <- map["innerCleanliness"]
        carImageUrl = "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/\(modelIdentifier)/\(color)/2x/car.png"

    }
}
