//
//  Networking.swift
//  ZogoFoto
//
//  Created by djchai on 1/19/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import Foundation
import Zip

class NetworkingService {
    
    
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
    
    static func downloadRequest(url: String, completion: @escaping (String?) -> Void) {
        let session = URLSession.shared
        let url = URL(string: url)
        let urlRequest = URLRequest(url: url!)
        
        session.downloadTask(with: urlRequest) { (url, response, error) in
            if let url = url {
                print(url)
                Zip.addCustomFileExtension("tmp")
                var caches = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
                print(caches)
                let _ = try? Zip.unzipFile(url, destination: URL(string:caches)!, overwrite: false, password: nil)
                completion(caches)
            }
        }.resume()
    }
 
}












