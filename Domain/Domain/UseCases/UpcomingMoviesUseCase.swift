//
//  UpcomingMoviesUseCase.swift
//  Domain
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation

public protocol UpcomingMoviesUseCase {
    func execute(page: Int) async throws -> MoviesPage
}

public final class DefaultUpcomingMoviesUseCase: UpcomingMoviesUseCase {

    private let moviesRepository: MoviesRepository

    public init(moviesRepository: MoviesRepository) {

        self.moviesRepository = moviesRepository
    }

    public func execute(page: Int) async throws -> MoviesPage {
        let moviesPage = try await moviesRepository.fetchUpcomingMovies(page: page)
        
        // Save recent query asynchronously
        Task {
          
        }
        
        return moviesPage
    }
}
