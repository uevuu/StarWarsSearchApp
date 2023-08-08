//
//  FavouriteViewIO.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 07.08.2023.
//

import UIKit

protocol FavouriteViewInput: AnyObject {
    func reloadTableView()
}

protocol FavouriteViewOutput: AnyObject {
    func viewWillAppearEvent()
    func getNumberOfSections() -> Int
    func getItemCount(in section: Int) -> Int
    func getCellClass(at indexPath: IndexPath) -> UITableViewCell.Type
    
    func getCharacter(at indexPath: IndexPath) -> Character
    func getStarship(at indexPath: IndexPath) -> Starship
    func getPlanet(at indexPath: IndexPath) -> Planet
    func getFilm(at indexPath: IndexPath) -> Film
    
    func removeCharacterFromFavourite(at position: Int)
    func removeStarshipFromFavourite(at position: Int)
    func removePlanetFromFavourite(at position: Int)
}
