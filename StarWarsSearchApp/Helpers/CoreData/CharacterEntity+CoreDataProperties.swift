//
//  CharacterEntity+CoreDataProperties.swift
//  
//
//  Created by Nikita Marin on 08.08.2023.
//
//

import Foundation
import CoreData

extension CharacterEntity {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<CharacterEntity> {
        return NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var gender: String?
    @NSManaged public var starshipsCount: Int32
    @NSManaged public var films: NSSet?
}

// MARK: Generated accessors for films
extension CharacterEntity {
    @objc(addFilmsObject:)
    @NSManaged public func addToFilms(_ value: FilmEntity)

    @objc(removeFilmsObject:)
    @NSManaged public func removeFromFilms(_ value: FilmEntity)

    @objc(addFilms:)
    @NSManaged public func addToFilms(_ values: NSSet)

    @objc(removeFilms:)
    @NSManaged public func removeFromFilms(_ values: NSSet)
}
