//
//  NowPlayingView.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import SwiftUI

struct NowPlayingView: View {
    
    @StateObject private var viewModel: NowPlayingViewModel
    
    init(viewModel: NowPlayingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.movies, id: \.id) { movie in
                MovieRow(movie: movie)
            }
            .navigationTitle("Now Playing")
            .onAppear {
                viewModel.fetchNowPlayingMovies()
            }
//            .alert(isPresented: $viewModel.showError) {
//                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
//            }
        }
    }
}

