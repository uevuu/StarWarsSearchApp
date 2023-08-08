//
//  SearchPresenter.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 05.08.2023.
//

import UIKit

final class SearchPresenter {
    private let charactersNetworkService: CharactersNetworkService
    private let starshipsNetworkService: StarshipsNetworkService
    private let planetsNetworkService: PlanetsNetworkService
    private let filmsNetworkService: FilmsNetworkService
    private let favouriteService: FavouriteService
    
    private var loadedCharacters: [Character] = []
    private var loadedStarships: [Starship] = []
    private var loadedPlanets: [Planet] = []
    
    private let possibleCellType = [
        CharacterTableViewCell.self,
        StarshipTableViewCell.self,
        PlanetTableViewCell.self
    ]
    weak var view: SearchViewInput?
    
    init(
        charactersNetworkService: CharactersNetworkService,
        starshipsNetworkService: StarshipsNetworkService,
        planetsNetworkService: PlanetsNetworkService,
        filmsNetworkService: FilmsNetworkService,
        favouriteService: FavouriteService
    ) {
        self.charactersNetworkService = charactersNetworkService
        self.starshipsNetworkService = starshipsNetworkService
        self.planetsNetworkService = planetsNetworkService
        self.filmsNetworkService = filmsNetworkService
        self.favouriteService = favouriteService
    }
}

extension SearchPresenter: SearchViewOutput {
    func viewWillAppearEvent() {
        view?.reloadTableView()
    }
    
    func getNumberOfSections() -> Int {
        return possibleCellType.count
    }
    
    func getItemCount(in section: Int) -> Int {
        switch section {
        case 0: return loadedCharacters.count
        case 1: return loadedStarships.count
        case 2: return loadedPlanets.count
        default: return 0
        }
    }
    
    func handleTextInput(_ text: String) {
        if text.count >= 2 {
            charactersNetworkService.getCharacters(name: text) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.loadedCharacters = response.results
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.reloadSection(0)
                    }
                case .failure(let error):
                    print(String(describing: error))
                }
            }
            
            starshipsNetworkService.getStarships(name: text) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.loadedStarships = response.results
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.reloadSection(1)
                    }
                case .failure(let error):
                    print(String(describing: error))
                }
            }
            
            self.planetsNetworkService.getPlanets(name: text) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.loadedPlanets = response.results
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.reloadSection(2)
                    }
                case .failure(let error):
                    print(String(describing: error))
                }
            }
        }
    }
    
    func getCellClass(at indexPath: IndexPath) -> UITableViewCell.Type {
        return possibleCellType[indexPath.section]
    }
    
    func getCharacter(at indexPath: IndexPath) -> Character {
        return loadedCharacters[indexPath.item]
    }
    
    func getStarship(at indexPath: IndexPath) -> Starship {
        return loadedStarships[indexPath.item]
    }
    
    func getPlanet(at indexPath: IndexPath) -> Planet {
        return loadedPlanets[indexPath.item]
    }
    
    func addCharacterToFavourite(at position: Int) {
        let dispatchGroup = DispatchGroup()
        var loadedFilms: [Film] = []
        let character = loadedCharacters[position]
        if favouriteService.characterIsAdded(character) {
            favouriteService.deleteCharacter(character)
            view?.reloadRow(IndexPath(item: position, section: 0))
        } else {
            character.films.forEach { filmUrl in
                dispatchGroup.enter()
                filmsNetworkService.getFilmInfo(with: filmUrl) { result in
                    defer {
                        dispatchGroup.leave()
                    }
                    switch result {
                    case .success(let film):
                        loadedFilms.append(film)
                    case .failure(let error):
                        print(String(describing: error))
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                self.favouriteService.addCharacter(character, with: loadedFilms)
                self.view?.reloadRow(IndexPath(item: position, section: 0))
            }
        }
    }
    
    func addStarshipToFavourite(at position: Int) {
        let dispatchGroup = DispatchGroup()
        var loadedFilms: [Film] = []
        let starship = loadedStarships[position]
        if favouriteService.starshipIsAdded(starship) {
            favouriteService.deleteStarship(starship)
            view?.reloadRow(IndexPath(item: position, section: 0))
        } else {
            starship.films.forEach { filmUrl in
                dispatchGroup.enter()
                filmsNetworkService.getFilmInfo(with: filmUrl) { result in
                    defer {
                        dispatchGroup.leave()
                    }
                    switch result {
                    case .success(let film):
                        loadedFilms.append(film)
                    case .failure(let error):
                        print(String(describing: error))
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                self.favouriteService.addStarship(starship, with: loadedFilms)
                self.view?.reloadRow(IndexPath(item: position, section: 1))
            }
        }
    }
    
    func addPlanetToFavourite(at position: Int) {
        let dispatchGroup = DispatchGroup()
        var loadedFilms: [Film] = []
        let planet = loadedPlanets[position]
        if favouriteService.planetIsAdded(planet) {
            favouriteService.deletePlanet(planet)
            view?.reloadRow(IndexPath(item: position, section: 0))
        } else {
            planet.films.forEach { filmUrl in
                dispatchGroup.enter()
                filmsNetworkService.getFilmInfo(with: filmUrl) { result in
                    defer {
                        dispatchGroup.leave()
                    }
                    switch result {
                    case .success(let film):
                        loadedFilms.append(film)
                    case .failure(let error):
                        print(String(describing: error))
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                self.favouriteService.addPlanet(planet, with: loadedFilms)
                self.view?.reloadRow(IndexPath(item: position, section: 1))
            }
        }
    }
    
    func itemIsAdded(at indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            return favouriteService.characterIsAdded(loadedCharacters[indexPath.item])
        case 1:
            return favouriteService.starshipIsAdded(loadedStarships[indexPath.item])
        case 2:
            return favouriteService.planetIsAdded(loadedPlanets[indexPath.item])
        default:
            return false
        }
    }
}
