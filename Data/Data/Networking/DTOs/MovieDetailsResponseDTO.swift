//
//  MovieDetailsResponseDTO.swift
//  Data
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation
import Domain

public struct MovieDetailsResponseDTO: Decodable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let posterPath: String?
    let overview: String?
    let genres: [GenreDTO]?
    let runtime: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case overview
        case genres
        case runtime
    }
}

public struct GenreDTO: Decodable {
    let id: Int?
    let name: String?
}

 extension MovieDetailsResponseDTO {
    
    func toMovieDomain() -> MovieDetails {
        return MovieDetails(
            id: self.id,
            title: self.title,
            releaseDate: self.releaseDate,
            posterURL: URL(string: "https://image.tmdb.org/t/p/w200\(posterPath ?? "")"),
            overview: self.overview,
            genres: self.genres?.compactMap { $0.name } ?? [],
            runtime: self.runtime
        )
    }
}
