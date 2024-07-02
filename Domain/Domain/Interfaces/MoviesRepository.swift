//
//  MoviesRepository.swift
//  Domain
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation

public protocol MoviesRepository {
    func fetchNowPlayingMovies(page: Int) async throws -> MoviesPage
    func fetchPopularMovies(page: Int) async throws -> MoviesPage
    func fetchUpcomingMovies(page: Int) async throws -> MoviesPage
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetails 
}
