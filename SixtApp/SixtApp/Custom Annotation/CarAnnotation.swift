//
//  CarAnnotation.swift
//  SixtApp
//
//  Created by Shabir Jan on 02/03/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import MapKit
class CarAnnotation: NSObject, MKAnnotation  {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var imageURL: String?
    
    
    //MARK: -Init methot to set coordinates, title , subtitle and image url for Annotations (Custom)
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, url : String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        imageURL = url
    }
}
