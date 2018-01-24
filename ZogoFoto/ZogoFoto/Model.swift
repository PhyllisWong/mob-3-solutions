//
//  Model.swift
//  ZogoFoto
//
//  Created by djchai on 1/19/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import Foundation


struct ImageCollection {
    
    let collectionName: String
    let zippedImagesUrl: URL
    var previewImage: URL?
    var thumbnail: String?
    var unzippedFolderURL: URL?
    
    init(collectionName: String, zippedImagesUrl: URL) {
        self.collectionName = collectionName
        self.zippedImagesUrl = zippedImagesUrl
    }
}

extension ImageCollection: Decodable {
    
    
    enum CodingKeys: String, CodingKey {
        case collectionName = "collection_name"
        case zip_url = "zipped_images_url"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let collectionName = try container.decode(String.self, forKey: .collectionName)
        let zip_url = try container.decode(URL.self, forKey: .zip_url)
        
        self.init(collectionName: collectionName, zippedImagesUrl: zip_url)
    }
}

