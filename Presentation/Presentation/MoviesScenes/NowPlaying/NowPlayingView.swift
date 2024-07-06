//
//  NowPlayingView.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import SwiftUI

public struct NowPlayingView: View {
    
    //MARK: - Properties -
    
    @StateObject private var viewModel: NowPlayingViewModel
    
    //MARK: - Init -
    
    public init(viewModel: NowPlayingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    //MARK: - Body -
    
    public var body: some View {
        NavigationView {
            List(viewModel.movies, id: \.id) { movie in
                MovieRow(movie: movie)
            }
            .navigationTitle("Now Playing")
            .onAppear {
                viewModel.fetchNowPlayingMovies()
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
        }
    }
}

