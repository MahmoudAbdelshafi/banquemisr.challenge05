//
//  MovieResponseDTO.swift
//  Data
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation
import Domain

// MARK: - MoviesPageResponseDTO

struct MoviesPageResponseDTO: Decodable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [MovieResponseDTO]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}

// MARK: - MovieResponseDTO

struct MovieResponseDTO: Decodable {
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

extension MovieResponseDTO {
    
    func toMovieDomain() -> Movie {
        return Movie(id: self.id,
                     title: self.title,
                     releaseDate: self.releaseDate,
                     posterURL:  URL(string: "https://image.tmdb.org/t/p/w200\(posterPath ?? "")"))
    }
}

extension MoviesPageResponseDTO {
    
    func toMoviesPageDomain() -> MoviesPage {
        return MoviesPage(page: self.page ?? 0,
                          totalResults: self.totalResults ?? 0,
                          totalPages: self.totalPages ?? 0,
                          movies: self.results?.compactMap { $0.toMovieDomain() } ?? [])
    }
}
