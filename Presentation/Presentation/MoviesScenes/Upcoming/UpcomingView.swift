//
//  UpcomingView.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import SwiftUI

struct UpcomingView: View {
    
    @StateObject private var viewModel: UpcomingViewModel
    
    init(viewModel: UpcomingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.movies, id: \.id) { movie in
                MovieRow(movie: movie)
            }
            .navigationTitle("Upcoming")
            .onAppear {
                viewModel.fetchUpcomingMovies()
            }
//            .alert(item: $viewModel.errorMessage) { errorMessage in
//                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
//            }
        }
    }
}

