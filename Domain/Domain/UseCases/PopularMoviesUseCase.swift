//
//  PopularMoviesUseCase.swift
//  Domain
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation

public protocol PopularMoviesUseCase {
    func execute(page: Int) async throws -> MoviesPage
}

public final class DefaultPopularMoviesUseCase: PopularMoviesUseCase {

    private let moviesRepository: MoviesRepository

    public init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    public func execute(page: Int) async throws -> MoviesPage {
        return try await moviesRepository.fetchPopularMovies(page: page)
    }
}
