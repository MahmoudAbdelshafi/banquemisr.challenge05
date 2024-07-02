//
//  Endpoint.swift
//  Networking
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol Endpoint {
    
    /// The target's base `URL`.
    var baseURL: String { get }
    
    /// The target's base `APIKey`.
    var APIKey: String { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The headers to be used in the request.
    var headers: [String: String]? { get }
    
    var queryItems: [URLQueryItem]? { get }
}
