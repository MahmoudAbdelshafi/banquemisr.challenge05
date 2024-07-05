//
//  ContentView.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import SwiftUI
import Data
import Domain
import Networking
import CoreData
import Cache

public struct ContentView: View {
    
    public init() {}
    
    private let networkService = TMDbNetworkService()
    
    public var body: some View {
         TabView {
             NowPlayingView(viewModel: NowPlayingViewModel(nowPlayingMoviesUseCase: DefaultNowPlayingMoviesUseCase(moviesRepository: DefaultMoviesRepository(networkService: networkService),
                                                                                                                   cachedNowPlayingMoviesRepository: DefaultCachedNowPlayingMoviesRepository())))
                .tabItem {
                    Label("Now Playing", systemImage: "film")
                }
            PopularView(viewModel: PopularViewModel(popularMoviesUseCase: DefaultPopularMoviesUseCase(moviesRepository: DefaultMoviesRepository(networkService: networkService))))
                .tabItem {
                    Label("Popular", systemImage: "star")
                }
            UpcomingView(viewModel: UpcomingViewModel(upcomingMoviesUseCase: DefaultUpcomingMoviesUseCase(moviesRepository: DefaultMoviesRepository(networkService: networkService))))
                .tabItem {
                    Label("Upcoming", systemImage: "calendar")
                }
        }
    }
}


#Preview {
    ContentView()
}
