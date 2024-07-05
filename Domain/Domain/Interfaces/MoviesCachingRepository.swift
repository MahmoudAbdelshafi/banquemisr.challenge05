//
//  MoviesCachingRepository.swift
//  Domain
//
//  Created by Mahmoud Abdelshafi on 05/07/2024.
//

import Foundation

public protocol CachedNowPlayingMoviesRepository {
    func saveNowPlayingMovies(moviesPage: MoviesPage) async throws
    func fetchNowPlayingMovies() async throws -> MoviesPage?
}
