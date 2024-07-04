//
//  UpcomingMoviesUseCaseTests.swift
//  DomainTests
//
//  Created by Mahmoud Abdelshafi on 04/07/2024.
//

import XCTest
@testable import Domain

class UpcomingMoviesUseCaseTests: XCTestCase {
    
    var sut: DefaultUpcomingMoviesUseCase!
    var mockMoviesRepository: MockMoviesRepository!
    
    override func setUp() {
        super.setUp()
        mockMoviesRepository = MockMoviesRepository()
        sut = DefaultUpcomingMoviesUseCase(moviesRepository: mockMoviesRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockMoviesRepository = nil
        super.tearDown()
    }
    
    func testExecuteWhenSuccessReturnsMoviesPage() async {
        // Given
        let expectedMoviesPage = MoviesPage(page: 1, totalResults: 10, totalPages: 1, movies: [])
        mockMoviesRepository.upcomingMoviesResult = .success(expectedMoviesPage)
        
        // When
        do {
            let moviesPage = try await sut.execute(page: 1)
            
            // Then
            XCTAssertEqual(moviesPage.page, expectedMoviesPage.page)
            XCTAssertEqual(moviesPage.totalResults, expectedMoviesPage.totalResults)
            XCTAssertEqual(moviesPage.totalPages, expectedMoviesPage.totalPages)
            XCTAssertEqual(moviesPage.movies.count, expectedMoviesPage.movies.count)
        } catch {
            XCTFail("Expected success but got \(error) instead")
        }
    }
    
    func testExecuteWhenFailureThrowsError() async {
        // Given
        let expectedError = NSError(domain: "TestError", code: -1, userInfo: nil)
        mockMoviesRepository.upcomingMoviesResult = .failure(expectedError)
        
        // When
        do {
            _ = try await sut.execute(page: 1)
            XCTFail("Expected error but got success instead")
        } catch {
            // Then
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}
