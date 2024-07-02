//
//  PopularViewModel.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation
import Domain

final class PopularViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?

    private let popularMoviesUseCase: PopularMoviesUseCase

    init(popularMoviesUseCase: PopularMoviesUseCase) {
        self.popularMoviesUseCase = popularMoviesUseCase
    }

    func fetchPopularMovies(page: Int = 1) {
        Task {
            do {
                let moviesPage = try await popularMoviesUseCase.execute(page: page)
                DispatchQueue.main.async {
                    self.movies = moviesPage.movies
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
