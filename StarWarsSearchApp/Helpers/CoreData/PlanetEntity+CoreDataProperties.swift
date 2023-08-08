//
//  PlanetEntity+CoreDataProperties.swift
//  
//
//  Created by Nikita Marin on 08.08.2023.
//
//

import Foundation
import CoreData

extension PlanetEntity {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<PlanetEntity> {
        return NSFetchRequest<PlanetEntity>(entityName: "PlanetEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var diameter: String?
    @NSManaged public var population: String?
    @NSManaged public var films: NSSet?
}

// MARK: Generated accessors for films
extension PlanetEntity {
    @objc(addFilmsObject:)
    @NSManaged public func addToFilms(_ value: FilmEntity)

    @objc(removeFilmsObject:)
    @NSManaged public func removeFromFilms(_ value: FilmEntity)

    @objc(addFilms:)
    @NSManaged public func addToFilms(_ values: NSSet)

    @objc(removeFilms:)
    @NSManaged public func removeFromFilms(_ values: NSSet)
}
