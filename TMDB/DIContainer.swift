//
//  DIContainer.swift
//  TMDB
//
//  Created by Mahmoud Abdelshafi on 06/07/2024.
//

import Foundation
import Data
import Domain
import Networking
import CoreData
import Caching
import Presentation

final class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    private lazy var networkService: TMDbNetworkService = {
        return TMDbNetworkService()
    }()
    
    private lazy var moviesRepository: MoviesRepository = {
        return DefaultMoviesRepository(networkService: networkService)
    }()
    
    private lazy var cachedNowPlayingMoviesRepository: CachedNowPlayingMoviesRepository = {
        return DefaultCachedNowPlayingMoviesRepository()
    }()
    
    @MainActor func makeNowPlayingViewModel() -> NowPlayingViewModel {
        return NowPlayingViewModel(nowPlayingMoviesUseCase: DefaultNowPlayingMoviesUseCase(moviesRepository: moviesRepository,
                                                                                           cachedNowPlayingMoviesRepository: cachedNowPlayingMoviesRepository))
    }
    
    @MainActor func makePopularViewModel() -> PopularViewModel {
        return PopularViewModel(popularMoviesUseCase: DefaultPopularMoviesUseCase(moviesRepository: moviesRepository))
    }
    
    @MainActor func makeUpcomingViewModel() -> UpcomingViewModel {
        return UpcomingViewModel(upcomingMoviesUseCase: DefaultUpcomingMoviesUseCase(moviesRepository: moviesRepository))
    }
}
