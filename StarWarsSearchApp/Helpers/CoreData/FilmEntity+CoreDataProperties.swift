//
//  FilmEntity+CoreDataProperties.swift
//  
//
//  Created by Nikita Marin on 08.08.2023.
//
//

import Foundation
import CoreData

extension FilmEntity {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<FilmEntity> {
        return NSFetchRequest<FilmEntity>(entityName: "FilmEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var producer: String?
    @NSManaged public var episodeId: Int32
    @NSManaged public var planet: PlanetEntity?
    @NSManaged public var character: CharacterEntity?
    @NSManaged public var starship: StarshipEntity?
}
