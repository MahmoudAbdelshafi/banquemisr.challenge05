//
//  PopularMoviesUseCaseTests.swift
//  DomainTests
//
//  Created by Mahmoud Abdelshafi on 04/07/2024.
//

import Foundation
import XCTest
import Domain

class DefaultPopularMoviesUseCaseTests: XCTestCase {
    
    var useCase: DefaultPopularMoviesUseCase!
    var mockMoviesRepository: MockMoviesRepository!

    override func setUp() {
        super.setUp()
        mockMoviesRepository = MockMoviesRepository()
        useCase = DefaultPopularMoviesUseCase(moviesRepository: mockMoviesRepository)
    }

    override func tearDown() {
        useCase = nil
        mockMoviesRepository = nil
        super.tearDown()
    }

    func testExecuteFetchesPopularMoviesSuccessfully() async throws {
        // Given
        let expectedMoviesPage = MoviesPage(page: 1, totalResults: 100, totalPages: 10, movies: [])
        mockMoviesRepository.popularMoviesResult = .success(expectedMoviesPage)
        
        // When
        let result = try await useCase.execute(page: 1)
        
        // Then
        XCTAssertEqual(result, expectedMoviesPage, "Expected to fetch popular movies successfully")
    }

    func testExecuteFetchesPopularMoviesFails() async throws {
        // Given
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockMoviesRepository.popularMoviesResult = .failure(expectedError)
        
        // When / Then
        do {
            _ = try await useCase.execute(page: 1)
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertEqual(error as NSError, expectedError, "Expected to receive the same error")
        }
    }
}

