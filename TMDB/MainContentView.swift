//
//  MainContentView.swift
//  TMDB
//
//  Created by Mahmoud Abdelshafi on 06/07/2024.
//

import SwiftUI
import Data
import Domain
import Networking
import CoreData
import Caching
import Presentation

public struct MainContentView: View {
    
    public init() {}
    
    private let diContainer = DIContainer.shared
       
       public var body: some View {
           TabView {
               NowPlayingView(viewModel: diContainer.makeNowPlayingViewModel())
                   .tabItem {
                       Label("Now Playing", systemImage: "film")
                   }
               PopularView(viewModel: diContainer.makePopularViewModel())
                   .tabItem {
                       Label("Popular", systemImage: "star")
                   }
               UpcomingView(viewModel: diContainer.makeUpcomingViewModel())
                   .tabItem {
                       Label("Upcoming", systemImage: "calendar")
                   }
           }
       }
}

