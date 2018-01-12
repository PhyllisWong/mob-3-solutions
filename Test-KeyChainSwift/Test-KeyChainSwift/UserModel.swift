//
//  UserModel.swift
//  Test-KeyChainSwift
//
//  Created by Phyllis Wong on 1/12/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension User: Decodable {
    
    enum UserKeys: String, CodingKey {
        case username
        case password
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        let username = try container.decode(String.self, forKey: .username)
        let password = try container.decode(String.self, forKey: .password)
        
        self.init(username: username, password: password)
    }
}
