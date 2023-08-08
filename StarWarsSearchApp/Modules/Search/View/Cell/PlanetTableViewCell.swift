//
//  PlanetTableViewCell.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 07.08.2023.
//

import UIKit

// MARK: - PlanetTableViewCell
final class PlanetTableViewCell: UITableViewCell {
    //  название, диаметр, кол-во населения.
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.systemBold(with: 22)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var diameterLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.systemRegular(with: 18)
        return label
    }()
    
    private lazy var populationLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.systemRegular(with: 18)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            nameLabel,
            diameterLabel,
            populationLabel
        ])
        stack.axis = .vertical
        stack.setCustomSpacing(10, after: nameLabel)
        stack.setCustomSpacing(5, after: diameterLabel)
        return stack
    }()
    
    lazy var addToFavouriteButton = AddToFavouriteButton()
    
    // MARK: Init
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setupView() {
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = true
        addSubview(stackView)
        addSubview(addToFavouriteButton)
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(10)
        }
        
        addToFavouriteButton.snp.makeConstraints {
            $0.leading.equalTo(stackView.snp.trailing).offset(10)
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.width.height.equalTo(30)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Configure
    
    func configureCell(
        name: String,
        diameter: String,
        population: String,
        isAdded: Bool
    ) {
        isAdded ? addToFavouriteButton.makeAdded() : addToFavouriteButton.makeDefault()
        nameLabel.text = name
        diameterLabel.text = "\(R.Strings.diameter): \(diameter)"
        populationLabel.text = "\(R.Strings.population): \(population)"
    }
}
