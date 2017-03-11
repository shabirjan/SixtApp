//
//  CarManager.swift
//  SixtApp
//
//  Created by Shabir Jan on 28/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import Foundation
import  Moya
import ObjectMapper
class CarManager {
    
    func fetchAllCars(completion:@escaping (_ cars:[Car]?, _ error:String?) -> Void)  {
        checkFileAtPath(path: getFilePath().path) ? completion(processJsonFile(getFilePath().path), nil) : getCars(completion: completion)
    }
    
    
    private func getCars(completion:@escaping (_ cars:[Car]?, _ error:String?) -> Void) {
        let apiManager = SixtAPIManager()
        apiManager.downloadFile {[weak self] (filePath, error) in
            guard  error == nil else {
                completion([], error)
                return
            }
            completion(self?.processJsonFile(filePath!), nil)
        }
    }
    
    
    
    private func processJsonFile(_ filePath:String) -> [Car]{
        return Mapper<Car>().mapArray(JSONObject: readFileAtPath(path: filePath))!
    }
    
    
}
