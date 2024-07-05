//
//  NowPlayingMoviesUseCase.swift
//  Domain
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation

public protocol NowPlayingMoviesUseCase {
    func execute(page: Int) async throws -> MoviesPage
}

public final class DefaultNowPlayingMoviesUseCase: NowPlayingMoviesUseCase {

    private let moviesRepository: MoviesRepository
    private let cachedNowPlayingMoviesRepository: CachedNowPlayingMoviesRepository

    public init(moviesRepository: MoviesRepository,
                cachedNowPlayingMoviesRepository: CachedNowPlayingMoviesRepository) {
        self.moviesRepository = moviesRepository
        self.cachedNowPlayingMoviesRepository = cachedNowPlayingMoviesRepository
    }

    public func execute(page: Int) async throws -> MoviesPage {
        // Try to fetch from cache first
        if let cachedMovies = try? await cachedNowPlayingMoviesRepository.fetchNowPlayingMovies() {
            return cachedMovies
        }

        // If not in cache, fetch from network
        let moviesPage = try await moviesRepository.fetchNowPlayingMovies(page: page)
        
        // Save fetched movies to cache
        try await cachedNowPlayingMoviesRepository.saveNowPlayingMovies(moviesPage: moviesPage)
        
        return moviesPage
    }
}
