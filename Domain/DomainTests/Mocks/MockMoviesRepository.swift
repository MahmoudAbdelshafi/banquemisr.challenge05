//
//  MockMoviesRepository.swift
//  DomainTests
//
//  Created by Mahmoud Abdelshafi on 03/07/2024.
//

import Foundation
import Combine
import XCTest
@testable import Domain

class MockMoviesRepository: MoviesRepository {
    var result: Result<MovieDetails, Error>?
    var popularMoviesResult: Result<MoviesPage, Error>!
    var nowPlayingMovies: Result<MoviesPage, Error>?

    func fetchUpcomingMovies(page: Int) async throws -> MoviesPage {
        throw NSError(domain: "", code: -1, userInfo: nil)
    }

    func fetchMovieDetails(movieID: Int) async throws -> MovieDetails {
        if let result = result {
            switch result {
            case .success(let movieDetails):
                return movieDetails
            case .failure(let error):
                throw error
            }
        } else {
            throw NSError(domain: "", code: -1, userInfo: nil)
        }
    }
    
    func fetchPopularMovies(page: Int) async throws -> MoviesPage {
        switch popularMoviesResult {
        case .success(let moviesPage):
            return moviesPage
        case .failure(let error):
            throw error
        case .none:
            fatalError("popularMoviesResult not set")
        }
    }

   func fetchNowPlayingMovies(page: Int) async throws -> MoviesPage {
        if let result = nowPlayingMovies {
            switch result {
            case .success(let moviesPage):
                return moviesPage
            case .failure(let error):
                throw error
            }
        }
        throw NSError(domain: "No Result Set", code: -1, userInfo: nil)
    }

}
