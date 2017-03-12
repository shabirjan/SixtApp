//
//  FileHelper.swift
//  SixtApp
//
//  Created by Shabir Jan on 28/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import Foundation

//MARK: -Helper method to get path of the file
func getFilePath() -> URL {
    let documentUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let destinationUrl = documentUrls?.appendingPathComponent("cars.json")
    return destinationUrl!
}
//MARK: -Helper method to check if file exists at path
func checkFileAtPath(path:String) -> Bool{
    return FileManager().fileExists(atPath: path) ? true : false
}
//MARK: -Helper method to save file at path
func saveFileAtPath(data:Data,path:URL) {
    do {
        try data.write(to: path)
    }
    catch{
        
    }
}
//MARK: -Helper method to read file content from the given path
func readFileAtPath(path:String) -> Any {
    do{
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        let jsonObj = try JSONSerialization.jsonObject(with:data, options:JSONSerialization.ReadingOptions(rawValue:0))
        return jsonObj
    }
    catch{
        return "Error"
    }
}
