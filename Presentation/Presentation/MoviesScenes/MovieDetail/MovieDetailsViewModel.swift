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
final class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    @Published var errorMessage: String?
    @Published var movieID: Int
    
    private let movieDetailsUseCase: MovieDetailsUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(movieDetailsUseCase: MovieDetailsUseCase,
         movieID: Int) {
        self.movieDetailsUseCase = movieDetailsUseCase
        self.movieID = movieID
    }
    
    func fetchMovieDetails() {
        Task {
            do {
                let details = try await movieDetailsUseCase.execute(movieID: movieID)
                self.movieDetails = details
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
