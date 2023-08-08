//
//  FavouritePresenter.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 07.08.2023.
//

import Foundation
import UIKit

final class FavouritePresenter {
    private let favouriteService: FavouriteService
    
    private var addedCharacters: [Character] = []
    private var addedStarships: [Starship] = []
    private var addedPlanets: [Planet] = []
    private var addedFilms: [Film] = []
    
    private let possibleCellType = [
        CharacterTableViewCell.self,
        StarshipTableViewCell.self,
        PlanetTableViewCell.self,
        FilmTableViewCell.self
    ]
    weak var view: FavouriteViewInput?
    
    init(favouriteService: FavouriteService) {
        self.favouriteService = favouriteService
    }
}

extension FavouritePresenter: FavouriteViewOutput {
    func viewWillAppearEvent() {
        addedCharacters = favouriteService.getCharacters()
        addedStarships = favouriteService.getStarships()
        addedPlanets = favouriteService.getPlanets()
        addedFilms = favouriteService.getFilms()
        DispatchQueue.main.async { [weak view] in
            view?.reloadTableView()
        }
    }
    
    func getNumberOfSections() -> Int {
        4
    }
    
    func getItemCount(in section: Int) -> Int {
        switch section {
        case 0: return addedCharacters.count
        case 1: return addedStarships.count
        case 2: return addedPlanets.count
        case 3: return addedFilms.count
        default: return 0
        }
    }
    
    func getCellClass(at indexPath: IndexPath) -> UITableViewCell.Type {
        return possibleCellType[indexPath.section]
    }
    
    func getCharacter(at indexPath: IndexPath) -> Character {
        return addedCharacters[indexPath.item]
    }
    
    func getStarship(at indexPath: IndexPath) -> Starship {
        return addedStarships[indexPath.item]
    }
    
    func getPlanet(at indexPath: IndexPath) -> Planet {
        return addedPlanets[indexPath.item]
    }
    
    func getFilm(at indexPath: IndexPath) -> Film {
        return addedFilms[indexPath.item]
    }
    
    func removeCharacterFromFavourite(at position: Int) {
        let character = addedCharacters.remove(at: position)
        favouriteService.deleteCharacter(character)
        addedFilms = favouriteService.getFilms()
        view?.reloadTableView()
    }
    
    func removeStarshipFromFavourite(at position: Int) {
        let starship = addedStarships.remove(at: position)
        favouriteService.deleteStarship(starship)
        addedFilms = favouriteService.getFilms()
        view?.reloadTableView()
    }
    
    func removePlanetFromFavourite(at position: Int) {
        let planet = addedPlanets.remove(at: position)
        favouriteService.deletePlanet(planet)
        addedFilms = favouriteService.getFilms()
        view?.reloadTableView()
    }
}
