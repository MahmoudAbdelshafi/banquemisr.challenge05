//
//  UpcomingViewModel.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation

import Foundation
import Combine
import Domain

@MainActor
final class UpcomingViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?
    
    private let upcomingMoviesUseCase: UpcomingMoviesUseCase
    
    init(upcomingMoviesUseCase: UpcomingMoviesUseCase) {
        self.upcomingMoviesUseCase = upcomingMoviesUseCase
    }
    
    func fetchUpcomingMovies() {
        Task {
            do {
                
                let moviesPage = try await upcomingMoviesUseCase.execute(page: 1)
                self.movies = moviesPage.movies
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
