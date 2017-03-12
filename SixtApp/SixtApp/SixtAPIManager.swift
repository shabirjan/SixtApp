//
//  SixtAPIManager.swift
//  SixtApp
//
//  Created by Shabir Jan on 01/03/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import Foundation
import Moya
class SixtAPIManager {
    let provider = MoyaProvider<SixtService>()
    
    
    //MARK: -Public method that download file from the URL and save the file 
    public func downloadFile(completion:@escaping (_ path:String?, _ error:String?) -> Void){
        provider.request(.downloadAllCars) { (result) in
            switch result{
            case let .success(response):
                 saveFileAtPath(data: response.data, path: getFilePath())
                completion(getFilePath().path, nil)
            case let .failure(error):
                completion(nil,error.localizedDescription)
            }
        }
    }
}
