//
//  NowPlayingViewModel.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation
import Domain
import Combine

@MainActor
public final class NowPlayingViewModel: ObservableObject {
    
    //MARK: - Properties -

    @Published var movies: [Movie] = []
    @Published var errorMessage: String?
    @Published var showError = false
    
    private let nowPlayingMoviesUseCase: NowPlayingMoviesUseCase
    
    //MARK: - Init -
    
    public init(nowPlayingMoviesUseCase: NowPlayingMoviesUseCase) {
        self.nowPlayingMoviesUseCase = nowPlayingMoviesUseCase
    }
    
    //MARK: - Functions -
    
    func fetchNowPlayingMovies(page: Int = 1) {
        showError = false
        Task {
            do {
                let moviesPage = try await nowPlayingMoviesUseCase.execute(page: page)
                self.movies = moviesPage.movies
            } catch {
                self.errorMessage = error.localizedDescription
                self.showError = true
            }
        }
    }
    
}
