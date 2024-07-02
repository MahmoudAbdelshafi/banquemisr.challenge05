//
//  NowPlayingViewModel.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation
import Domain

final class NowPlayingViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?

    private let nowPlayingMoviesUseCase: NowPlayingMoviesUseCase

    init(nowPlayingMoviesUseCase: NowPlayingMoviesUseCase) {
        self.nowPlayingMoviesUseCase = nowPlayingMoviesUseCase
    }

    func fetchNowPlayingMovies(page: Int = 1) {
        Task {
            do {
                let moviesPage = try await nowPlayingMoviesUseCase.execute(page: page)
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
