//
//  CachedMovieDTO.swift
//  Data
//
//  Created by Mahmoud Abdelshafi on 05/07/2024.
//

import Foundation
import Cache
import Domain
import CoreData

struct CachedMovieDTO {
    let id: Int
    let title: String
    let releaseDate: String
    let posterURL: URL
    
    func toDomain() -> Movie {
        return Movie(
            id: id,
            title: title,
            releaseDate: releaseDate,
            posterURL: posterURL
        )
    }
}

extension CachedMovie {
    func toDTO() -> CachedMovieDTO {
        return CachedMovieDTO(
            id: Int(id),
            title: title ?? "",
            releaseDate: releaseDate ?? "",
            posterURL: URL(string: posterURL ?? "")!
        )
    }
}

extension CachedMovieDTO {
    func toCoreDataEntity(context: NSManagedObjectContext) -> CachedMovie {
        let entity = CachedMovie(context: context)
        entity.id = Int32(id)
        entity.title = title
        entity.releaseDate = releaseDate
        entity.posterURL = posterURL.absoluteString
        return entity
    }
}

