//
//  PopularViewModel.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation
import Domain
import Combine

@MainActor
public final class PopularViewModel: ObservableObject {
    
    //MARK: - Properties -
    
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?
    @Published var showError = false
    @Published var isLoading = false
    @Published var moviesPage: MoviesPage = MoviesPage()
    
    private let popularMoviesUseCase: PopularMoviesUseCase
    
    //MARK: - Init -
    
    public init(popularMoviesUseCase: PopularMoviesUseCase) {
        self.popularMoviesUseCase = popularMoviesUseCase
    }
    
    //MARK: - Functions -
    
    func fetchPopularMovies() {
        guard !isLoading, moviesPage.checkIfHasMorePages else { return }
        
        isLoading = true
        showError = false
        
        Task {
            do {
                let moviesPage = try await popularMoviesUseCase.execute(page: moviesPage.page)
                self.movies.append(contentsOf: moviesPage.movies)
                self.moviesPage = moviesPage
            } catch {
                self.errorMessage = error.localizedDescription
                self.showError = true
            }
            
            isLoading = false
        }
    }
    
}
