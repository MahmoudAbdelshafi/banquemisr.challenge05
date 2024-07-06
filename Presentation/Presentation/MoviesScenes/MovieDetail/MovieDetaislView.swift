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
    
    //MARK: - Properties -
    
    @StateObject private var viewModel: MovieDetailsViewModel
    
    //MARK: - Init -
    
    public init(movieID: Int, movieDetailsUseCase: MovieDetailsUseCase) {
        let viewModel = MovieDetailsViewModel(movieDetailsUseCase: movieDetailsUseCase, movieID: movieID)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    //MARK: - body -
    
    public var body: some View {
           ScrollView {
               VStack(alignment: .center, spacing: 16) {
                   posterImageView
                   
                   titleTextView
                   
                   releaseDateTextView
                   
                   runtimeTextView
                   
                   genresTextView
                   
                   overviewHeaderTextView
                   
                   overviewTextView
               }
               .padding()
           }
           .navigationTitle(viewModel.movieDetails?.title ?? "Movie Details")
           .navigationBarTitleDisplayMode(.inline)
           .onAppear {
               viewModel.fetchMovieDetails()
           }
           .navigationViewStyle(StackNavigationViewStyle())
           .accessibility(identifier: "MovieDetailsView")
       }
       
       //MARK: - Private Views -
       
       private var posterImageView: some View {
           AsyncCachedImage(url: viewModel.movieDetails?.posterURL) { image in
               image
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: 220, height: 440)
                   .cornerRadius(8)
           } placeholder: {
               ProgressView()
           }
       }
       
       private var titleTextView: some View {
           Text(viewModel.movieDetails?.title ?? "Unknown Title")
               .font(.largeTitle)
               .fontWeight(.bold)
       }
       
       private var releaseDateTextView: some View {
           Text("Release Date: \(viewModel.movieDetails?.releaseDate?.formattedDate ?? "Unknown")")
               .font(.subheadline)
               .foregroundColor(.gray)
       }
       
       private var runtimeTextView: some View {
           Text("Runtime: \(viewModel.movieDetails?.runtime.map { "\($0) minutes" } ?? "Unknown")")
               .font(.subheadline)
               .foregroundColor(.gray)
       }
       
       private var genresTextView: some View {
           if let genres = viewModel.movieDetails?.genres, !genres.isEmpty {
               return Text("Genres: \(genres.joined(separator: ", "))")
                   .font(.subheadline)
                   .foregroundColor(.gray)
           } else {
               return Text("")
           }
       }
       
       private var overviewHeaderTextView: some View {
           Text("Overview")
               .font(.headline)
               .padding(.top, 8)
       }
       
       private var overviewTextView: some View {
           Text(viewModel.movieDetails?.overview ?? "No overview available.")
               .font(.body)
       }
    
}

extension MovieDetailsView {
    static func instantiate(id: Int) -> MovieDetailsView {
        return MovieDetailsView(movieID: id,
                                movieDetailsUseCase: DefaultMovieDetailsUseCase(moviesRepository:  DefaultMoviesRepository(networkService: TMDbNetworkService())))
    }
}
