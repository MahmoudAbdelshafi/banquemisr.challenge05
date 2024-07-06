//
//  DefaultCachedNowPlayingMoviesRepository.swift
//  Data
//
//  Created by Mahmoud Abdelshafi on 05/07/2024.
//

import CoreData
import Combine
import Domain
import CoreData
import Caching

public class DefaultCachedNowPlayingMoviesRepository: CachedNowPlayingMoviesRepository {
    
    private let coreDataStorage: CoreDataStorage
    
   public init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    public func saveNowPlayingMovies(moviesPage: MoviesPage) async throws {
        try await coreDataStorage.performBackgroundTask { context in
            do {
                _ = moviesPage.toCoreDataEntity(context: context)
                try context.save()
            } catch {
                debugPrint("Error saving context: \(error)")
            }
        }
    }

    public func fetchNowPlayingMovies() async throws -> MoviesPage? {
        var fetchedMoviesPage: MoviesPage?
        try await coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = CachedMoviesPage.fetchRequest()
                fetchRequest.fetchLimit = 1
                
                if let result = try context.fetch(fetchRequest).first {
                    fetchedMoviesPage = result.toDomainDTO()
                }
            } catch {
                debugPrint("Error fetching context: \(error)")
//                throw error
            }
        }
        return fetchedMoviesPage
    }



}
