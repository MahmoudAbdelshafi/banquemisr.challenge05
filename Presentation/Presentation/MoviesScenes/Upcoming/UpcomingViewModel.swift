//
//  UpcomingViewModel.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation
import Combine
import Domain

@MainActor
public final class UpcomingViewModel: ObservableObject {
    
    //MARK: - Properties -
    
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?
    @Published var showError = false
    
    private let upcomingMoviesUseCase: UpcomingMoviesUseCase
    
    //MARK: - Init -
    
    public init(upcomingMoviesUseCase: UpcomingMoviesUseCase) {
        self.upcomingMoviesUseCase = upcomingMoviesUseCase
    }
    
    //MARK: - Functions -
    
    func fetchUpcomingMovies() {
        self.showError = false
        Task {
            do {
                let moviesPage = try await upcomingMoviesUseCase.execute(page: 1)
                self.movies = moviesPage.movies
            } catch {
                self.errorMessage = error.localizedDescription
                self.showError = true
            }
        }
    }
}
