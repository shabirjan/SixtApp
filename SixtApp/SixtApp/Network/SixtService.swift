//
//  SixtService.swift
//  SixtApp
//
//  Created by Shabir Jan on 28/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import Moya

enum SixtService {
    case downloadAllCars
}

extension SixtService : TargetType{
    
    var baseURL : URL {
        return URL(string: "http://www.codetalk.de")!
    }
    
    var path: String {
        switch self {
        case .downloadAllCars:
            return "/cars.json"
        }
    }
    
    var method : Moya.Method {
        switch self {
        case .downloadAllCars:
            return .get
        }
    }
    var parameters : [String:Any]?{
        switch self {
        case .downloadAllCars:
            return nil
        }
    }
    var parameterEncoding : ParameterEncoding{
        switch self {
        case .downloadAllCars:
            return URLEncoding.default
        }
    }
    var sampleData : Data{
        switch self {
        default:
            return Data()
        }
    }
    var task : Task{
        return .request
    }
}
