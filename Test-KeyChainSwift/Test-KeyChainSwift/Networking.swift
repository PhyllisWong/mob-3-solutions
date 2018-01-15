//
//  Networking.swift
//  Test-KeyChainSwift
//
//  Created by Phyllis Wong on 1/12/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import Foundation
// import KeychainSwift


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


class Networking {
    
    // networking method
    
    static func fetch(route: Route, completionHandler: @escaping(Data, Int) -> Void) {
        
        // Set the URL string and append the path
        let baseURL = "http://127.0.0.1:5000/"
        let fullURLString = URL.init(string: baseURL.appending(route.urlPath()))
        
        // Append the URL params using the KeychainSwift library
        let requestURLString = fullURLString?.appendingPathComponent(route.urlPath())
        
        var components = URLComponents(url: requestURLString!, resolvingAgainstBaseURL: true)
        components?.queryItems = route.urlParams()
        
        var request = URLRequest(url: components!.url!)
        request.allHTTPHeaderFields = route.header(token: "Basic dGVzdDp0ZXN0")
        request.httpMethod = route.httpMethod().rawValue
        
        request.httpBody = route.body()
        
        // Create the URL Session
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, err) in
            guard let res = response else {return}
            
            // downcast to get the http status code
            let statusCode: Int = (res as! HTTPURLResponse).statusCode
            
            if let data = data {
                completionHandler(data, statusCode)
            }
        }.resume()
    }
}












