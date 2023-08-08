//
//  FavouriteViewController.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 07.08.2023.
//

import UIKit

// MARK: - FavouriteViewController
final class FavouriteViewController: UIViewController {
    private let output: FavouriteViewOutput
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.register(CharacterTableViewCell.self)
        table.register(StarshipTableViewCell.self)
        table.register(PlanetTableViewCell.self)
        table.register(FilmTableViewCell.self)
        table.dataSource = self
        return table
    }()
    
    // MARK: - Init
    
    init(output: FavouriteViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTitleItems()
        setupView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output.viewWillAppearEvent()
    }
    
    // MARK: - Setups
    
    private func configureTitleItems() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Private
    
    @objc private func addCharacterButtonTapped(_ sender: CharacterTableViewCell) {
        output.removeCharacterFromFavourite(at: sender.tag)
    }
    
    @objc private func addStarshipButtonTapped(_ sender: StarshipTableViewCell) {
        output.removeStarshipFromFavourite(at: sender.tag)
    }
    
    @objc private func addPlanetButtonTapped(_ sender: PlanetTableViewCell) {
        output.removePlanetFromFavourite(at: sender.tag)
    }
}

extension FavouriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.getNumberOfSections()
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return output.getItemCount(in: section)
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cellClass = output.getCellClass(at: indexPath)
        let cell = tableView.dequeueReusableCell(cellClass, for: indexPath)
        cell.selectionStyle = .none
        
        switch cell {
        case let characterCell as CharacterTableViewCell:
            let character = output.getCharacter(at: indexPath)
            characterCell.configureCell(
                name: character.name,
                gender: character.gender,
                starshipsCount: character.starshipsCount,
                isAdded: true
            )
            characterCell.addToFavouriteButton.addTarget(
                self,
                action: #selector(addCharacterButtonTapped(_:)),
                for: .touchUpInside
            )
            characterCell.addToFavouriteButton.tag = indexPath.item
            return characterCell
        case let starshipCell as StarshipTableViewCell:
            let starship = output.getStarship(at: indexPath)
            starshipCell.configureCell(
                name: starship.name,
                model: starship.model,
                manufacturer: starship.manufacturer,
                passengersCount: starship.passengers,
                isAdded: true
            )
            starshipCell.addToFavouriteButton.addTarget(
                self,
                action: #selector(addStarshipButtonTapped(_:)),
                for: .touchUpInside
            )
            starshipCell.addToFavouriteButton.tag = indexPath.item
            return starshipCell
        case let planetCell as PlanetTableViewCell:
            let planet = output.getPlanet(at: indexPath)
            planetCell.configureCell(
                name: planet.name,
                diameter: planet.diameter,
                population: planet.population,
                isAdded: true
            )
            planetCell.addToFavouriteButton.addTarget(
                self,
                action: #selector(addPlanetButtonTapped(_:)),
                for: .touchUpInside
            )
            planetCell.addToFavouriteButton.tag = indexPath.item
            return planetCell
        case let filmCell as FilmTableViewCell:
            let film = output.getFilm(at: indexPath)
            filmCell.configureCell(
                title: film.title,
                director: film.director,
                producer: film.producer
            )
            return filmCell
        default:
            return UITableViewCell()
        }
    }
}

extension FavouriteViewController: FavouriteViewInput {
    func reloadTableView() {
        tableView.reloadData()
    }
}
