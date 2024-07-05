//
//  CachedMovie+CoreDataClass.swift
//  Cache
//
//  Created by Mahmoud Abdelshafi on 05/07/2024.
//

import CoreData
import Domain


@objc(CachedMovie)
public class CachedMovie: NSManagedObject {
}

extension CachedMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedMovie> {
        return NSFetchRequest<CachedMovie>(entityName: "CachedMovie")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var posterURL: String?
}

extension Movie {
    func toCoreDataEntity(context: NSManagedObjectContext) -> CachedMovie {
        let entity = CachedMovie(context: context)
        entity.id = Int32(self.id ?? 0)
        entity.title = self.title
        entity.releaseDate = self.releaseDate
        entity.posterURL = self.posterURL?.absoluteString
        return entity
    }
}

extension CachedMovie {
    public func toDomainDTO() -> Movie {
        return Movie(id: Int(self.id),
                     title: self.title,
                     releaseDate: self.releaseDate,
                     posterURL: URL(string: self.posterURL ?? ""))
    }
}
