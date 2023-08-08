//
//  StarshipEntity+CoreDataProperties.swift
//  
//
//  Created by Nikita Marin on 08.08.2023.
//
//

import Foundation
import CoreData

extension StarshipEntity {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<StarshipEntity> {
        return NSFetchRequest<StarshipEntity>(entityName: "StarshipEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var model: String?
    @NSManaged public var manufacturer: String?
    @NSManaged public var passengers: String?
    @NSManaged public var films: NSSet?
}

// MARK: Generated accessors for films
extension StarshipEntity {
    @objc(addFilmsObject:)
    @NSManaged public func addToFilms(_ value: FilmEntity)

    @objc(removeFilmsObject:)
    @NSManaged public func removeFromFilms(_ value: FilmEntity)

    @objc(addFilms:)
    @NSManaged public func addToFilms(_ values: NSSet)

    @objc(removeFilms:)
    @NSManaged public func removeFromFilms(_ values: NSSet)
}
