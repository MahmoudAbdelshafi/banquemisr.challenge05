//
//  CachedMoviesPage+CoreDataClass.swift
//  Cache
//
//  Created by Mahmoud Abdelshafi on 05/07/2024.
//

import CoreData
import Domain

@objc(CachedMoviesPage)
public class CachedMoviesPage: NSManagedObject {
}

extension CachedMoviesPage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedMoviesPage> {
        return NSFetchRequest<CachedMoviesPage>(entityName: "CachedMoviesPage")
    }

    static func create(in context: NSManagedObjectContext) -> CachedMoviesPage {
        let entityDescription = NSEntityDescription.entity(forEntityName: "CachedMoviesPage", in: context)!
        let cachedMoviesPage = CachedMoviesPage(entity: entityDescription, insertInto: context)
        return cachedMoviesPage
    }

    @NSManaged public var page: Int32
    @NSManaged public var totalResults: Int32
    @NSManaged public var totalPages: Int32
    @NSManaged public var movies: NSSet?
}

extension MoviesPage {
    public func toCoreDataEntity(context: NSManagedObjectContext) -> CachedMoviesPage {
        let entity = CachedMoviesPage.create(in: context)
        entity.page = Int32(self.page)
        entity.totalResults = Int32(self.totalResults)
        entity.totalPages = Int32(self.totalPages)
        let moviesSet = NSSet(array: self.movies.map { $0.toCoreDataEntity(context: context) })
        entity.movies = moviesSet
        return entity
    }
}

extension CachedMoviesPage {
    public func toDomainDTO() -> MoviesPage {
        let moviesArray = (self.movies?.allObjects as? [CachedMovie])?.map { $0.toDomainDTO() } ?? []
        return MoviesPage(page: Int(self.page),
                          totalResults: Int(self.totalResults),
                          totalPages: Int(self.totalPages),
                          movies: moviesArray)
    }
}
