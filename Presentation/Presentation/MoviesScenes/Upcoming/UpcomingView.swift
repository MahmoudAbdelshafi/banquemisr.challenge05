//
//  UpcomingView.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import SwiftUI

public struct UpcomingView: View {
    
    //MARK: - Properties -
    
    @StateObject private var viewModel: UpcomingViewModel
    
    //MARK: - Init -
    
    public init(viewModel: UpcomingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    //MARK: - Body -
    
    public var body: some View {
        NavigationView {
            List(viewModel.movies, id: \.id) { movie in
                MovieRow(movie: movie)
            }
            .navigationTitle("Upcoming")
            .onAppear {
                viewModel.fetchUpcomingMovies()
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
        }
    }
}

