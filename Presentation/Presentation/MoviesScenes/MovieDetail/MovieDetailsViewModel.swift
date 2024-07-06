//
//  MovieDetailsViewModel.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Combine
import Foundation
import Domain

@MainActor
public final class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    @Published var errorMessage: String?
    @Published var movieID: Int
    @Published var showError = false
    
    private let movieDetailsUseCase: MovieDetailsUseCase
    private var cancellables = Set<AnyCancellable>()
    
    public init(movieDetailsUseCase: MovieDetailsUseCase,
         movieID: Int) {
        self.movieDetailsUseCase = movieDetailsUseCase
        self.movieID = movieID
    }
    
    func fetchMovieDetails() {
        showError = false
        Task {
            do {
                let details = try await movieDetailsUseCase.execute(movieID: movieID)
                self.movieDetails = details
            } catch {
                self.errorMessage = error.localizedDescription
                self.showError = true
            }
        }
    }
}
