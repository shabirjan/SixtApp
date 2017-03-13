//
//  Car.swift
//  SixtApp
//
//  Created by Shabir Jan on 28/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import Foundation
import ObjectMapper

enum CarTransmissionType : String {
    case manual = "Manual"
    case automatic = "Automatic"
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
    
    //MARK: Computed Properties
    var carTitle : String{
        return make + "•" + modelName
    }
    var carTransmision : String {
        return "Transmission : \(transmission.lowercased() == "m" ? CarTransmissionType.manual : CarTransmissionType.automatic)"
    }
    var carCleanliness : String {
        return "Cleanliness  : \(innerCleanliness)"
    }
    
    required init?(map: Map) { }
    
    //MARK: -Mapper method to map response JSON into model
    func mapping(map: Map) {
        id <- map["id"]
        modelIdentifier <- map ["modelIdentifier"]
        modelName <- map["modelName"]
        make <- map["make"]
        color <- map["color"]
        transmission  <- map["transmission"]
        latitude   <- map["latitude"]
        longitude   <- map["longitude"]
        innerCleanliness  <- map["innerCleanliness"]
        carImageUrl = "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/\(modelIdentifier)/\(color)/2x/car.png"
    }
}
