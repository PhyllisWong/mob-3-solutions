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
                let name = i.title
                let zipURL = i.zipUrl
                print(name)
                print(zipURL)
                let destinationUrl = Networking.unzip(url: zipURL)! // force unwrap, so if it crashes the code sucks
                print(destinationUrl)
//                downloadZip(url: zipURL, completionHandler: { (destinationUrl) in
//                    <#code#>
//                })
            }
        }
    }
    
    static func downloadZip(url: URL, completionHandler: @escaping ( _ destinationUrl: URL) -> Void) {
        // use alamofire to get the files at each zipUrl
        
        let urlSession = URLSession.shared
        urlSession.downloadTask(with: url) { (destinationURL, response, err) in
            if err == nil {
                // do this if there is no error
                // give me back where the zip was downloaded to
                completionHandler(destinationURL!)
            }
        }
        // return the location of where the folder is downloaded to
    }
}

// MARK: fix the zip functionality here!
extension Networking {
    
    static func unzip(url: URL) -> URL? {
        
        do {
            let libraryFolder = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask) [0]
            let cacheFolder = libraryFolder.appendingPathComponent("Caches", isDirectory: true)
            
            try Zip.unzipFile(url, destination: cacheFolder, overwrite: true, password: nil) //Unzip
            
            return cacheFolder
            
            
            
        } catch {
            print("something went terribly wrong")
            return nil
        }
    }
}












