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
    //MARK: -Public method exposed to user for fetching cars
    func fetchAllCars(completion:@escaping (_ cars:[Car]?, _ error:String?) -> Void)  {
        checkFileAtPath(path: getFilePath().path) ? completion(processJsonFile(getFilePath().path), nil) : getCars(completion: completion)
    }
    
    //MARK: -Private method to download file from network and saves the file
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
    
    
    //MARK: -Private method to map JSON content into the model
    private func processJsonFile(_ filePath:String) -> [Car]{
        return Mapper<Car>().mapArray(JSONObject: readFileAtPath(path: filePath))!
    }
    
    
}
