//
//  MockNetworkEndPoints.swift
//  NetworkingTests
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation
@testable import Networking

enum MockNetworkEndPoints: Endpoint {
    case mockEndpoint
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/" // testing url
    }
    
    var APIKey: String {
        return "840d9830ce5ea69425c3f231dbc1f7b3" // testing key should be dummy one not related to the app real key
    }
    
    var path: String {
        switch self {
        case .mockEndpoint:
            return "/movie/now_playing"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem(name: "api_key", value: "840d9830ce5ea69425c3f231dbc1f7b3")]
        switch self {
        case .mockEndpoint:
            items.append(URLQueryItem(name: "page", value: "\(1)"))
        }
        return items
    }
}
