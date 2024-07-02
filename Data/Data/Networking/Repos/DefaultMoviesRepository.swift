//
//  DefaultMoviesRepository.swift
//  Data
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation
import Domain
import Networking
import Combine

public class DefaultMoviesRepository: MoviesRepository {
    private let networkService: NetworkService
    private var cancellables = Set<AnyCancellable>()

    public init(networkService: NetworkService) {
        self.networkService = networkService
    }

    public func fetchNowPlayingMovies(page: Int) async throws -> MoviesPage {
        return try await fetchMovies(endpoint: NetworkEndPoints.nowPlaying(page: page))
    }

    public func fetchPopularMovies(page: Int) async throws -> MoviesPage {
        return try await fetchMovies(endpoint: NetworkEndPoints.popular(page: page))
    }

    public func fetchUpcomingMovies(page: Int) async throws -> MoviesPage {
        return try await fetchMovies(endpoint: NetworkEndPoints.upcomingMovies(page: page))
    }

    public func fetchMovieDetails(movieID: Int) async throws -> MovieDetails {
        return try await fetchMovie(endpoint: NetworkEndPoints.movieDetails(movieID: movieID))
    }

    private func fetchMovies(endpoint: Endpoint) async throws -> MoviesPage {
        try await withCheckedThrowingContinuation { continuation in
            networkService.fetch(endpoint: endpoint)
                .sink { completion in
                    if case let .failure(error) = completion {
                        continuation.resume(throwing: error)
                    }
                } receiveValue: { (responseDTO: MoviesPageResponseDTO) in
                    let moviesPage = responseDTO.toMoviesPageDomain()
                    continuation.resume(returning: moviesPage)
                }
                .store(in: &cancellables)
        }
    }

    private func fetchMovie(endpoint: Endpoint) async throws -> MovieDetails {
        try await withCheckedThrowingContinuation { continuation in
            networkService.fetch(endpoint: endpoint)
                .sink { completion in
                    if case let .failure(error) = completion {
                        continuation.resume(throwing: error)
                    }
                } receiveValue: { (responseDTO: MovieDetailsResponseDTO) in
                    let movie = responseDTO.toMovieDomain()
                    continuation.resume(returning: movie)
                }
                .store(in: &cancellables)
        }
    }
}
