//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import XCTest
@testable import Presentation
import Domain

final class PopularViewModelTests: XCTestCase {
    var viewModel: PopularViewModel!
    var mockUseCase: MockPopularMoviesUseCase!

    @MainActor override func setUp() {
        super.setUp()
        mockUseCase = MockPopularMoviesUseCase()
        viewModel = PopularViewModel(popularMoviesUseCase: mockUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }

    @MainActor func testFetchPopularMoviesSuccess() {
        // Given
        let expectedMovies = [
            Movie(id: 1, title: "Test Movie 1", releaseDate: "2024-01-01", posterURL: URL(string: "https://example.com/poster1.jpg")),
            Movie(id: 2, title: "Test Movie 2", releaseDate: "2024-01-02", posterURL: URL(string: "https://example.com/poster2.jpg"))
        ]
        let moviesPage = MoviesPage(page: 1, totalResults: 2, totalPages: 1, movies: expectedMovies)
        mockUseCase.moviesPage = moviesPage

        let expectation = XCTestExpectation(description: "Fetch popular movies successfully")

        // When
        viewModel.fetchPopularMovies()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.movies, expectedMovies)
            XCTAssertFalse(self.viewModel.showError)
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    @MainActor func testFetchPopularMoviesFailure() {
        // Given
        mockUseCase.shouldThrowError = true

        let expectation = XCTestExpectation(description: "Handle error when fetching popular movies")

        // When
        viewModel.fetchPopularMovies()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.viewModel.showError)
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertTrue(self.viewModel.movies.isEmpty)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}

