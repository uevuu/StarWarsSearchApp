//
//  SearchViewIO.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 05.08.2023.
//

import UIKit

protocol SearchViewInput: AnyObject {
    func reloadTableView()
    func reloadSection(_ section: Int)
    func reloadRow(_ indexPath: IndexPath)
}

protocol SearchViewOutput: AnyObject {
    func viewWillAppearEvent()
    func getNumberOfSections() -> Int
    func getItemCount(in section: Int) -> Int
    func handleTextInput(_ text: String)
    func getCellClass(at indexPath: IndexPath) -> UITableViewCell.Type
    
    func getCharacter(at indexPath: IndexPath) -> Character
    func getStarship(at indexPath: IndexPath) -> Starship
    func getPlanet(at indexPath: IndexPath) -> Planet
    
    func addCharacterToFavourite(at position: Int)
    func addStarshipToFavourite(at position: Int)
    func addPlanetToFavourite(at position: Int)
    
    func itemIsAdded(at indexPath: IndexPath) -> Bool
}
