//
//  PopularView.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import SwiftUI

public struct PopularView: View {
    
    //MARK: - Properties -
    
    @StateObject private var viewModel: PopularViewModel
    
    //MARK: - Init -
    
    public init(viewModel: PopularViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    //MARK: - Body -
    
    public var body: some View {
        NavigationView {
            List(viewModel.movies, id: \.id) { movie in
                MovieRow(movie: movie)
                    .accessibilityIdentifier("MovieRow")
                    .onAppear {
                        if viewModel.movies.last == movie {
                            viewModel.fetchPopularMovies()
                        }
                    }
            }
            .accessibilityIdentifier("movieList")
            .navigationTitle("Popular")
            .onAppear {
                viewModel.fetchPopularMovies()
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""),
                      dismissButton: .default(Text("OK")))
            }
            .overlay(
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    }
                }, alignment: .bottom
            )
        }
    }
    
}
