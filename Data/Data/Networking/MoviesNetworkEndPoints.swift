//
//  NetworkEndPoints.swift
//  Data
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation
import Networking

enum MoviesNetworkEndPoints {
    case nowPlaying(page: Int)
    case popular(page: Int)
    case upcomingMovies(page: Int)
    case movieDetails(movieID: Int)
}

extension MoviesNetworkEndPoints: Endpoint {
    
    public var baseURL: String {
        return NetworkAppConfiguration.shared.apiBaseURL
    }
    
    public var APIKey: String {
        return NetworkAppConfiguration.shared.apiKey
    }

    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        case .popular:
            return "/movie/popular"
        case .upcomingMovies:
            return "/movie/upcoming"
        case .movieDetails(let movieID):
            return "/movie/\(movieID)"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem(name: "api_key", value: NetworkAppConfiguration.shared.apiKey)]
        switch self {
        case .nowPlaying(let page), .popular(let page), .upcomingMovies(let page):
            items.append(URLQueryItem(name: "page", value: "\(page)"))
        case .movieDetails:
            break 
        }
        return items
    }
}
