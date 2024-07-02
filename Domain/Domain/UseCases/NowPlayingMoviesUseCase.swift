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

    public init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    public func execute(page: Int) async throws -> MoviesPage {
        return try await moviesRepository.fetchNowPlayingMovies(page: page)
    }
}
