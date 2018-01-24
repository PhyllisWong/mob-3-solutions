//
//  Networking.swift
//  ZogoFoto
//
//  Created by djchai on 1/19/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import Foundation
import Zip

class Networking {
    
    
    static func fetchRequest(url: String, completion: @escaping (Data) -> Void) {
        
        let session = URLSession.shared
        let url = URL(string: url)
        let urlRequest = URLRequest(url: url!)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                completion(data)
            }
        }.resume()
    }
    
    static func downloadRequest(imageCollection: ImageCollection, completion: @escaping (_ cachesURL: URL) -> Void) {
        let session = URLSession.shared
        let url = imageCollection.zippedImagesUrl
        let urlRequest = URLRequest(url: url)
        
        session.downloadTask(with: urlRequest) { (url, response, error) in
            if let url = url {
                print(url)
                
                Zip.addCustomFileExtension("tmp")
                
                let fm = FileManager.default
                let cacheURL = try! fm.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                print(cacheURL)
                let _ = try? Zip.unzipFile(
                    url,
                    destination: cacheURL,
                    overwrite: false,
                    password: nil
                )
                completion(cacheURL)
            }
        }.resume()
    }
 
}












