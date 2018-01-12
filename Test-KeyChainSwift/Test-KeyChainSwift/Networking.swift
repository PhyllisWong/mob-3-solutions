//
//  Networking.swift
//  Test-KeyChainSwift
//
//  Created by Phyllis Wong on 1/12/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import Foundation


/*
 Parts of the HTTP Request
 1. Request Method: GET, PUT, DELETE or POST
 2. Header
 3. URL Path
 4. URL Parameters
 5. Body
 */


// HTTP Method types
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

// Server routes
enum Route {
    case userSignup(user: User)
    case userLogin(user: User)
    
    // #1 func to get the correct HTTP Method
    func httpMethod() -> HTTPMethod {
        switch self {
        case .userSignup:
            return .post
        case .userLogin:
            return .get
        }
    }
    
    // #2 func to create the correct header required by the server
    func header(token: String) -> [String: String] {
        switch self {
        case .userSignup, .userLogin:
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "\(token)",
                    "Host": "http://127.0.0.1:5000/users"
            ]
        }
    }
    
    // #3 URL path to use for routes
    func urlPath() -> String {
        switch self {
        case .userSignup, .userLogin:
            return "/users"
        default:
            return "/users"
        }
    }
    
    // #4 URL Params to pass if any
    // URLQueryItem - A single name-value pair from the query portion of a URL
    func urlParams() -> [URLQueryItem] {
        switch self {
        case .userSignup:
            return []
        case .userLogin(let user):
            return [URLQueryItem(name: "username", value: user.username)]
        }
    }
        
    // #5 json body
    func body() -> Data? {
        switch self {
        case let .userSignup(user):
            var jsonBody = Data()
            do {
                // encode the user object into a json object
                jsonBody = try JSONEncoder().encode(user)
            } catch {}
            return jsonBody
            
        default: return nil
        }
    
    }
}


















