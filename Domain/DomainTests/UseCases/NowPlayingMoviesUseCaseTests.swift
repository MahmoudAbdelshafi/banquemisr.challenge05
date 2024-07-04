//
//  NowPlayingMoviesUseCaseTests.swift
//  DomainTests
//
//  Created by Mahmoud Abdelshafi on 04/07/2024.
//

import XCTest
@testable import Domain

final class DefaultNowPlayingMoviesUseCaseTests: XCTestCase {

    func testExecuteWhenSuccessReturnsMoviesPage() async throws {
        // Given
        let moviesPage = MoviesPage(page: 1, totalResults: 100, totalPages: 10, movies: [])
        let mockRepository = MockMoviesRepository()
        mockRepository.nowPlayingMovies = .success(moviesPage)
        let useCase = DefaultNowPlayingMoviesUseCase(moviesRepository: mockRepository)
        
        // When
        let result = try await useCase.execute(page: 1)
        
        // Then
        XCTAssertEqual(result, moviesPage, "The use case should return the same MoviesPage as the repository.")
    }
    
    func testExecuteWhenFailureThrowsError() async {
        // Given
        let expectedError = NSError(domain: "Test", code: 1, userInfo: nil)
        let mockRepository = MockMoviesRepository()
        mockRepository.nowPlayingMovies = .failure(expectedError)
        let useCase = DefaultNowPlayingMoviesUseCase(moviesRepository: mockRepository)
        
        // When & Then
        do {
            _ = try await useCase.execute(page: 1)
            XCTFail("The use case should throw an error.")
        } catch {
            XCTAssertEqual(error as NSError, expectedError, "The use case should throw the same error as the repository.")
        }
    }
}



