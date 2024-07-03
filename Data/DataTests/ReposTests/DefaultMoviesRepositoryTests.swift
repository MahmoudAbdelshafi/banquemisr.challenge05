//
//  DefaultMoviesRepositoryTests.swift
//  DataTests
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import XCTest
import Combine
@testable import Data
import Networking
import Domain

class DefaultMoviesRepositoryTests: XCTestCase {
    var repository: DefaultMoviesRepository!
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        repository = DefaultMoviesRepository(networkService: mockNetworkService)
        cancellables = []
    }

    override func tearDown() {
        repository = nil
        mockNetworkService = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchNowPlayingMoviesSuccess() async {
        let moviesPage = MoviesPage(page: 1, totalResults: 1, totalPages: 1, movies: [Movie(id: 1, title: "Test Movie", releaseDate: "2022-01-01", posterURL: nil)])
        let responseDTO = MoviesPageResponseDTO(page: 1, totalResults: 1, totalPages: 1, results: [MovieResponseDTO(id: 1, title: "Test Movie", releaseDate: "2022-01-01", posterPath: nil)])
        
        mockNetworkService.fetchResult = Just(responseDTO)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
        
        do {
            let result = try await repository.fetchNowPlayingMovies(page: 1)
            XCTAssertEqual(result.page, moviesPage.page)
            XCTAssertEqual(result.totalResults, moviesPage.totalResults)
            XCTAssertEqual(result.totalPages, moviesPage.totalPages)
            XCTAssertEqual(result.movies.first?.id, moviesPage.movies.first?.id)
        } catch {
            XCTFail("Expected success, but got error: \(error)")
        }
    }

    func testFetchNowPlayingMoviesFailure() async {
        mockNetworkService.fetchResult = Fail(error: NetworkError.requestFailed)
            .eraseToAnyPublisher()
        
        do {
            _ = try await repository.fetchNowPlayingMovies(page: 1)
            XCTFail("Expected failure, but got success")
        } catch {
            XCTAssertEqual(error as? NetworkError, .requestFailed)
        }
    }

    // Similar tests for fetchPopularMovies, fetchUpcomingMovies, fetchMovieDetails...

    func testFetchMovieDetailsSuccess() async {
        let movieDetails = MovieDetails(id: 1, title: "Test Movie", releaseDate: "Test Overview", posterURL: URL(string: "zs2S0D4sZMNbOKgs4LyZAxiX9eY.jpg")!, overview: "2022-01-01", genres: [], runtime: nil)
        let responseDTO = MovieDetailsResponseDTO(id: 1, title: "Test Movie", releaseDate: "Test Overview", posterPath: "zs2S0D4sZMNbOKgs4LyZAxiX9eY.jpg", overview: "2022-01-01", genres: [], runtime: nil)
        
        mockNetworkService.fetchResult = Just(responseDTO)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
        
        do {
            let result = try await repository.fetchMovieDetails(movieID: 1)
            XCTAssertEqual(result.id, movieDetails.id)
            XCTAssertEqual(result.title, movieDetails.title)
            XCTAssertEqual(result.overview, movieDetails.overview)
            XCTAssertEqual(result.genres, movieDetails.genres)
            XCTAssertEqual(result.releaseDate, movieDetails.releaseDate)
            XCTAssertEqual(result.runtime, movieDetails.runtime)
        } catch {
            XCTFail("Expected success, but got error: \(error)")
        }
    }

    func testFetchMovieDetailsFailure() async {
        mockNetworkService.fetchResult = Fail(error: NetworkError.requestFailed)
            .eraseToAnyPublisher()
        
        do {
            _ = try await repository.fetchMovieDetails(movieID: 1)
            XCTFail("Expected failure, but got success")
        } catch {
            XCTAssertEqual(error as? NetworkError, .requestFailed)
        }
    }
}
