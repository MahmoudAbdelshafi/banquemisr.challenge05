//
//  MovieDetailView.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation
import Domain
import SwiftUI
import Data
import Networking

public struct MovieDetailsView: View {
    @StateObject private var viewModel: MovieDetailsViewModel
        
    public init(movieID: Int, movieDetailsUseCase: MovieDetailsUseCase) {
            let viewModel = MovieDetailsViewModel(movieDetailsUseCase: movieDetailsUseCase, movieID: movieID)
            _viewModel = StateObject(wrappedValue: viewModel)
        }
        
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                AsyncCachedImage(url: viewModel.movieDetails?.posterURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 220, height: 440)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
                
                Text(viewModel.movieDetails?.title ?? "Unknown Title")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Release Date: \(viewModel.movieDetails?.releaseDate?.formattedDate ?? "Unknown")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Runtime: \(viewModel.movieDetails?.runtime.map { "\($0) minutes" } ?? "Unknown")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                if let genres = viewModel.movieDetails?.genres, !genres.isEmpty {
                    Text("Genres: \(genres.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Text("Overview")
                    .font(.headline)
                    .padding(.top, 8)
                
                Text(viewModel.movieDetails?.overview ?? "No overview available.")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(viewModel.movieDetails?.title ?? "Movie Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            viewModel.fetchMovieDetails()
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Optional: Use a specific navigation view style if needed
                .accessibility(identifier: "MovieDetailsView") // Assigning accessibil
    }
}

extension MovieDetailsView {
    static func instantiate(id: Int) -> MovieDetailsView {
        return MovieDetailsView(movieID: id,
                                movieDetailsUseCase: DefaultMovieDetailsUseCase(moviesRepository:  DefaultMoviesRepository(networkService: TMDbNetworkService())))
    }
}
