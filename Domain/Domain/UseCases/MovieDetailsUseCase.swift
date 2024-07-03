//
//  MovieDetailsUseCase.swift
//  Domain
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation

public protocol MovieDetailsUseCase {
    func execute(movieID: Int) async throws -> MovieDetails
}

public final class DefaultMovieDetailsUseCase: MovieDetailsUseCase {

    private let moviesRepository: MoviesRepository

    public init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    public func execute(movieID: Int) async throws -> MovieDetails {
        return try await moviesRepository.fetchMovieDetails(movieID: movieID)
    }
}
