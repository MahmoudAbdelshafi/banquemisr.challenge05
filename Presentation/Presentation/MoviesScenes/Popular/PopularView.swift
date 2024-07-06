//
//  PopularView.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import SwiftUI

public struct PopularView: View {
    
    @StateObject private var viewModel: PopularViewModel
    
    public init(viewModel: PopularViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationView {
            List(viewModel.movies, id: \.id) { movie in
                MovieRow(movie: movie)
                    .accessibilityIdentifier("MovieRow")
            }
            .accessibilityIdentifier("movieList")
            .navigationTitle("Popular")
            .onAppear {
                viewModel.fetchPopularMovies()
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
        }
    }
}
