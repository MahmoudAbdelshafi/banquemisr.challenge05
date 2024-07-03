//
//  MockAPIBaseResponse.swift
//  NetworkingTests
//
//  Created by Mahmoud Abdelshafi on 03/07/2024.
//

import Foundation

// MARK: - MockAPIBaseResponse

struct MockAPIBaseResponse: Decodable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [MockAPIResponse]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}

// MARK: - MockAPIResponse

struct MockAPIResponse: Decodable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
