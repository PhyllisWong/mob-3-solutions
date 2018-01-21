//
//  Model.swift
//  ZogoFoto
//
//  Created by djchai on 1/19/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import Foundation
import UIKit

struct ImageCollection: Decodable {
    
    let title: String
    let zipUrl: URL
    var previewImage: URL? = nil
    var contentUrl: URL? = nil
    
    enum CodingKeys: String, CodingKey {
        case title = "collection_name"
        case zipUrl = "zipped_images_url"
        
    }
}


