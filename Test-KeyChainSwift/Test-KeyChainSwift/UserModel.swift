//
//  UserModel.swift
//  Test-KeyChainSwift
//
//  Created by Phyllis Wong on 1/12/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import Foundation
import KeychainSwift


struct User {
    let username: String
    let password: String
    var keychain = KeychainSwift()
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
        let credential = BasicAuth.generateBasicAuthHeader(username: self.username, password: self.password)
        
        self.keychain.set(credential, forKey: "credential")
    }
}

extension User: Decodable {
    
    enum UserKeys: String, CodingKey {
        case username
        case password
    }
    
    // decode the json data to Swift
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        let username = try container.decode(String.self, forKey: .username)
        let password = try container.decode(String.self, forKey: .password)
        
        self.init(username: username, password: password)
    }
}

extension User: Encodable {
    
    // encode the Swift data to json
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(password, forKey: .password)
    }
    
}
