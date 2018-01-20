//
//  Networking.swift
//  ZogoFoto
//
//  Created by djchai on 1/19/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import Foundation
import Zip
import Alamofire

struct Networking {

    static func makeGETRequest(completionHandler: @escaping ([ImageCollection]) -> Void) {
        request("https://s3-us-west-2.amazonaws.com/mob3/image_collection.json").responseData { (response) in
            if let JSONData = response.result.value {
                print(JSONData)
                
                // Decode the jsonObject to Swift model
                let decoder = JSONDecoder()
                
                if let decodedModel = try? decoder.decode([ImageCollection].self, from: JSONData) {
                    // print(decodedModel)
                    completionHandler(decodedModel)
                }
                
            }
        }
    }
    
    static func getZipUrls() {
        makeGETRequest { (jsonObject) in
            print(jsonObject)
            
            for i in jsonObject {
                let name = i.collection_name
                let zipURL = i.zipped_images_url
                print(name)
                print(zipURL)
            }
        }
    }
}

// MARK: fix the zip functionality here!
extension Networking {
    
    func unzip(url: URL) {
        
        do {
            let filePath = Bundle.main.url(forResource: "file", withExtension: "zip")!
            let picsDirectory = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask) [0]
            try Zip.unzipFile(filePath, destination: picsDirectory, overwrite: true, password: "password", progress: { (progress) in
                print(progress)
            }) //Zip
        } catch {
            print("something went terribly wrong")
        }
    }
}












