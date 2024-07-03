//
//  MockPopularMoviesUseCase.swift
//  PresentationTests
//
//  Created by Mahmoud Abdelshafi on 03/07/2024.
//

import Foundation
@testable import Presentation
import Domain

class MockPopularMoviesUseCase: PopularMoviesUseCase {
    var shouldThrowError = false
    var moviesPage = MoviesPage(page: 1, totalResults: 2, totalPages: 1, movies: [])

    func execute(page: Int) async throws -> MoviesPage {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        }
        return moviesPage
    }
}
