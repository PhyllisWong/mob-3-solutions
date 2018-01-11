//
//  MovieModel.swift
//  Test-UserDefaults
//
//  Created by djchai on 1/10/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import Foundation

class Movie: NSObject, NSCoding {
    var title: String
    var leadActor: String
    
    init(title: String, leadActor: String) {
        self.title = title
        self.leadActor = leadActor
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: "title") as? String
            else { return nil }
        guard let leadActor = aDecoder.decodeObject(forKey: "leadActor") as? String
            else { return nil }
        
        self.init(title: title, leadActor: leadActor)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.leadActor, forKey: "leadActor")
    }
}



