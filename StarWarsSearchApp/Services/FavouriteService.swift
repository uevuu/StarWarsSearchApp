//
//  FavouriteService.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 07.08.2023.
//

import Foundation
import CoreData

protocol FavouriteService {
    func getCharacters() -> [Character]
    func addCharacter(_ character: Character, with films: [Film])
    func deleteCharacter(_ character: Character)
    func characterIsAdded(_ character: Character) -> Bool
    
    func getStarships() -> [Starship]
    func addStarship(_ starship: Starship, with films: [Film])
    func deleteStarship(_ starship: Starship)
    func starshipIsAdded(_ starship: Starship) -> Bool
    
    func getPlanets() -> [Planet]
    func addPlanet(_ planet: Planet, with films: [Film])
    func deletePlanet(_ planet: Planet)
    func planetIsAdded(_ planet: Planet) -> Bool
    
    func getFilms() -> [Film]
}

// MARK: - FavouriteService
final class FavouriteServiceImpl: FavouriteService {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StarWarsSearchApp")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    private lazy var context = persistentContainer.viewContext
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error with saving context: \(error)")
        }
    }
}

// MARK: - Operations with Characters
extension FavouriteServiceImpl {
    func getCharacters() -> [Character] {
        let fetchRequest: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
        if let characterEntities = try? context.fetch(fetchRequest) {
            var characters: [Character] = []
            characterEntities.forEach { characterEntity in
                let character = Character(
                    name: characterEntity.name ?? "",
                    gender: characterEntity.gender ?? "",
                    starshipsCount: Int(characterEntity.starshipsCount),
                    films: []
                )
                characters.append(character)
            }
            return characters
        }
        return []
    }
    
    func addCharacter(_ character: Character, with films: [Film]) {
        if characterIsAdded(character) {
            return
        }
        let characterEntity = CharacterEntity(context: context)
        characterEntity.name = character.name
        characterEntity.gender = character.gender
        characterEntity.starshipsCount = Int32(character.starshipsCount)
        var filmEntities: [FilmEntity] = []
        films.forEach { film in
            let filmEntity = FilmEntity(context: context)
            filmEntity.title = film.title
            filmEntity.episodeId = Int32(film.episodeId)
            filmEntity.producer = film.producer
            filmEntity.director = film.director
            filmEntity.character = characterEntity
            filmEntities.append(filmEntity)
        }
        characterEntity.films = NSSet(array: filmEntities)
        saveContext()
    }
    
    func deleteCharacter(_ character: Character) {
        let fetchRequest: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", character.name)
        if let character = try? context.fetch(fetchRequest).first {
            if let filmEntities = character.films?.allObjects as? [FilmEntity] {
                filmEntities.forEach { filmEntity in
                    context.delete(filmEntity)
                }
            }

            context.delete(character)
            saveContext()
        }
    }
    
    func characterIsAdded(_ character: Character) -> Bool {
        let fetchRequest: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", character.name)
        if let characters = try? context.fetch(fetchRequest) {
            return characters.first != nil
        }
        return false
    }
}

// MARK: - Operations with Starships
extension FavouriteServiceImpl {
    func getStarships() -> [Starship] {
        let fetchRequest: NSFetchRequest<StarshipEntity> = StarshipEntity.fetchRequest()
        if let starshipEntities = try? context.fetch(fetchRequest) {
            var starships: [Starship] = []
            starshipEntities.forEach { starshipEntity in
                let starship = Starship(
                    name: starshipEntity.name ?? "",
                    model: starshipEntity.model ?? "",
                    manufacturer: starshipEntity.manufacturer ?? "",
                    passengers: starshipEntity.passengers ?? "",
                    films: []
                )
                starships.append(starship)
            }
            return starships
        }
        return []
    }
    
    func addStarship(_ starship: Starship, with films: [Film]) {
        if starshipIsAdded(starship) {
            return
        }
        let starshipEntity = StarshipEntity(context: context)
        starshipEntity.name = starship.name
        starshipEntity.model = starship.model
        starshipEntity.manufacturer = starship.manufacturer
        starshipEntity.passengers = starship.passengers
        var filmEntities: [FilmEntity] = []
        films.forEach { film in
            let filmEntity = FilmEntity(context: context)
            filmEntity.title = film.title
            filmEntity.episodeId = Int32(film.episodeId)
            filmEntity.producer = film.producer
            filmEntity.director = film.director
            filmEntity.starship = starshipEntity
            filmEntities.append(filmEntity)
        }
        starshipEntity.films = NSSet(array: filmEntities)
        saveContext()
    }
    
    func deleteStarship(_ starship: Starship) {
        let fetchRequest: NSFetchRequest<StarshipEntity> = StarshipEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", starship.name)
        if let starship = try? context.fetch(fetchRequest).first {
            if let filmEntities = starship.films?.allObjects as? [FilmEntity] {
                filmEntities.forEach { filmEntity in
                    context.delete(filmEntity)
                }
            }
            context.delete(starship)
            saveContext()
        }
    }
    
    func starshipIsAdded(_ starship: Starship) -> Bool {
        let fetchRequest: NSFetchRequest<StarshipEntity> = StarshipEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", starship.name)
        if let starship = try? context.fetch(fetchRequest) {
            return starship.first != nil
        }
        return false
    }
}

// MARK: - Operations with Planets
extension FavouriteServiceImpl {
    func getPlanets() -> [Planet] {
        let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
        if let planetEntities = try? context.fetch(fetchRequest) {
            var planets: [Planet] = []
            planetEntities.forEach { planetEntity in
                let planet = Planet(
                    name: planetEntity.name ?? "",
                    diameter: planetEntity.diameter ?? "",
                    population: planetEntity.population ?? "",
                    films: []
                )
                planets.append(planet)
            }
            return planets
        }
        return []
    }
    
    func addPlanet(_ planet: Planet, with films: [Film]) {
        if planetIsAdded(planet) {
            return
        }
        let planetEntity = PlanetEntity(context: context)
        planetEntity.name = planet.name
        planetEntity.population = planet.population
        planetEntity.diameter = planet.diameter
        var filmEntities: [FilmEntity] = []
        films.forEach { film in
            let filmEntity = FilmEntity(context: context)
            filmEntity.title = film.title
            filmEntity.episodeId = Int32(film.episodeId)
            filmEntity.producer = film.producer
            filmEntity.director = film.director
            filmEntity.planet = planetEntity
            filmEntities.append(filmEntity)
        }
        planetEntity.films = NSSet(array: filmEntities)
        saveContext()
    }
    
    func deletePlanet(_ planet: Planet) {
        let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", planet.name)
        if let planet = try? context.fetch(fetchRequest).first {
            if let filmEntities = planet.films?.allObjects as? [FilmEntity] {
                filmEntities.forEach { filmEntity in
                    context.delete(filmEntity)
                }
            }
            context.delete(planet)
            saveContext()
        }
    }
    
    func planetIsAdded(_ planet: Planet) -> Bool {
        let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", planet.name)
        if let planet = try? context.fetch(fetchRequest) {
            return planet.first != nil
        }
        return false
    }
}

// MARK: - Operations with Films
extension FavouriteServiceImpl {
    func getFilms() -> [Film] {
        let fetchRequest: NSFetchRequest<FilmEntity> = FilmEntity.fetchRequest()
        if let filmEntities = try? context.fetch(fetchRequest) {
            var films: [Film] = []
            filmEntities.forEach { filmEntity in
                let planet = Film(
                    title: filmEntity.title ?? "",
                    episodeId: Int(filmEntity.episodeId),
                    director: filmEntity.director ?? "",
                    producer: filmEntity.producer ?? ""
                )
                films.append(planet)
            }
            saveContext()
            return films
        }
        return []
    }
}
