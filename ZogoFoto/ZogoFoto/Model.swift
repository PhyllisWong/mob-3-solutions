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
    let zippedImagesUrl: String
    var previewImage: [URL]?
    var thumbnail: String?
    
    init(collectionName: String, zippedImagesUrl: String) {
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
        let zip_url = try container.decode(String.self, forKey: .zip_url)
        
        self.init(collectionName: collectionName, zippedImagesUrl: zip_url)
    }
}

