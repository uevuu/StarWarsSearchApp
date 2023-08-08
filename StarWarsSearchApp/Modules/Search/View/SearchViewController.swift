//
//  SearchViewController.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 05.08.2023.
//

import UIKit
import SnapKit

// MARK: - SearchViewController
final class SearchViewController: UIViewController {
    private let output: SearchViewOutput
    
    private let possibleCellType = [
        CharacterTableViewCell.self,
        StarshipTableViewCell.self,
        PlanetTableViewCell.self
    ]
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.placeholder = R.Strings.search
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.register(CharacterTableViewCell.self)
        table.register(StarshipTableViewCell.self)
        table.register(PlanetTableViewCell.self)
        table.dataSource = self
        return table
    }()
    
    // MARK: - Init
    
    init(output: SearchViewOutput) {
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
            navigationItem.titleView = searchBar
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
        output.addCharacterToFavourite(at: sender.tag)
    }
    
    @objc private func addStarshipButtonTapped(_ sender: StarshipTableViewCell) {
        output.addStarshipToFavourite(at: sender.tag)
    }
    
    @objc private func addPlanetButtonTapped(_ sender: PlanetTableViewCell) {
        output.addPlanetToFavourite(at: sender.tag)
    }
}

extension SearchViewController: UITableViewDataSource {
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
        let cellClass = possibleCellType[indexPath.section]
        let cell = tableView.dequeueReusableCell(cellClass, for: indexPath)
        let isAdded = output.itemIsAdded(at: indexPath)
        cell.selectionStyle = .none
        
        switch cell {
        case let characterCell as CharacterTableViewCell:
            let character = output.getCharacter(at: indexPath)
            characterCell.configureCell(
                name: character.name,
                gender: character.gender,
                starshipsCount: character.starshipsCount,
                isAdded: isAdded
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
                isAdded: isAdded
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
                isAdded: isAdded
            )
            planetCell.addToFavouriteButton.addTarget(
                self,
                action: #selector(addPlanetButtonTapped(_:)),
                for: .touchUpInside
            )
            planetCell.addToFavouriteButton.tag = indexPath.item
            return planetCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        output.handleTextInput(searchText)
    }
}

extension SearchViewController: SearchViewInput {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func reloadSection(_ section: Int) {
        tableView.reloadSections(
            IndexSet(integer: section),
            with: .fade
        )
    }
    
    func reloadRow(_ indexPath: IndexPath) {
        tableView.reloadRows(
            at: [indexPath],
            with: .none
        )
    }
}
