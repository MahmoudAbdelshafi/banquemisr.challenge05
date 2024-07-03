//
//  PopularViewModel.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation
import Domain

@MainActor
final class PopularViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?
    @Published var showError = false
    
    private let popularMoviesUseCase: PopularMoviesUseCase
    
    init(popularMoviesUseCase: PopularMoviesUseCase) {
        self.popularMoviesUseCase = popularMoviesUseCase
    }
    
    func fetchPopularMovies(page: Int = 1) {
        showError = false
        Task {
            do {
                let moviesPage = try await popularMoviesUseCase.execute(page: page)
                self.movies = moviesPage.movies
            } catch {
                self.errorMessage = error.localizedDescription
                self.showError = true
            }
        }
    }
}
