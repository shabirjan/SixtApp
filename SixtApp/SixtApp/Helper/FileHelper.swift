//
//  FileHelper.swift
//  SixtApp
//
//  Created by Shabir Jan on 28/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import Foundation

class FileHelper: NSObject {

    func getFilePath() -> URL {
        let documentUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destinationUrl = documentUrls?.appendingPathComponent("cars.json")
        return destinationUrl!
    }
    func checkFileAtPath() -> Bool{
        return FileManager().fileExists(atPath: getFilePath().path) ? true : false
    }
}
