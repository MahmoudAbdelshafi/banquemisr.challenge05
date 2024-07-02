//
//  MoviesPage.swift
//  Domain
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation

public struct MovieQuery: Equatable {
    let query: String
}

public struct MoviesPage {
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let movies: [Movie]
    
    public enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
    
    public init(page: Int, totalResults: Int, totalPages: Int, movies: [Movie]) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.movies = movies
    }
}
