//
//  CachedMoviesPageDTO.swift
//  Data
//
//  Created by Mahmoud Abdelshafi on 05/07/2024.
//

import Foundation
import Cache
import Domain
import CoreData

public struct CachedMoviesPageDTO {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let movies: [CachedMovieDTO]
    
    func toDomain() -> MoviesPage {
        return MoviesPage(
            page: page,
            totalResults: totalResults,
            totalPages: totalPages,
            movies: movies.map { $0.toDomain() }
        )
    }
}

extension CachedMoviesPage {
    func toDTO() -> CachedMoviesPageDTO {
        return CachedMoviesPageDTO(
            page: Int(page),
            totalResults: Int(totalResults),
            totalPages: Int(totalPages),
            movies: (movies?.allObjects as? [CachedMovie])?.map { $0.toDTO() } ?? []
        )
    }
}

extension CachedMoviesPageDTO {
     func toCoreDataEntity(context: NSManagedObjectContext) -> CachedMoviesPage {
        let entity = CachedMoviesPage(context: context)
        entity.page = Int32(page)
        entity.totalResults = Int32(totalResults)
        entity.totalPages = Int32(totalPages)
        let moviesSet = NSSet(array: movies.map { $0.toCoreDataEntity(context: context) })
        entity.movies = moviesSet
        return entity
    }
}
