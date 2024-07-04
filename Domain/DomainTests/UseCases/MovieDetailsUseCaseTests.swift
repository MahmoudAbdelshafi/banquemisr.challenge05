//
//  DefaultMovieDetailsUseCaseTests.swift
//  DomainTests
//
//  Created by Mahmoud Abdelshafi on 03/07/2024.
//

import Foundation
import Combine
import XCTest
@testable import Domain

final class DefaultMovieDetailsUseCaseTests: XCTestCase {

    var mockMoviesRepository: MockMoviesRepository!
    var movieDetailsUseCase: DefaultMovieDetailsUseCase!

    override func setUp() {
        super.setUp()
        mockMoviesRepository = MockMoviesRepository()
        movieDetailsUseCase = DefaultMovieDetailsUseCase(moviesRepository: mockMoviesRepository)
    }

    override func tearDown() {
        mockMoviesRepository = nil
        movieDetailsUseCase = nil
        super.tearDown()
    }

    func testExecute_Success() async {
        // Given
        let expectedMovieDetails = MovieDetails(id: 1, title: "Test Movie", releaseDate: "Test Overview", posterURL: URL(string: ""), overview: "overview", genres: [], runtime: 443)
        mockMoviesRepository.result = .success(expectedMovieDetails)

        do {
            // When
            let movieDetails = try await movieDetailsUseCase.execute(movieID: 1)

            // Then
            XCTAssertEqual(movieDetails, expectedMovieDetails)
        } catch {
            XCTFail("Expected success, but got error: \(error)")
        }
    }

    func testExecute_Failure() async {
        // Given
        mockMoviesRepository.result = .failure(NSError(domain: "", code: -1, userInfo: nil))

        do {
            // When
            _ = try await movieDetailsUseCase.execute(movieID: 1)

            // Then
            XCTFail("Expected error, but got success")
        } catch {
            // Success if it catches an error
        }
    }
}
