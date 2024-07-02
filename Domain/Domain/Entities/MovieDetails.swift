//
//  MovieDetails.swift
//  Domain
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation

public struct MovieDetails {
    public let id: Int?
    public let title: String?
    public let releaseDate: String?
    public let posterURL: URL?
    public let overview: String?
    public let genres: [String]?
    public let runtime: Int?
    
    public init(id: Int?, title: String?, releaseDate: String?, posterURL: URL?, overview: String?, genres: [String]?, runtime: Int?) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.posterURL = posterURL
        self.overview = overview
        self.genres = genres
        self.runtime = runtime
    }
}
