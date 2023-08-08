//
//  CharacterTableViewCell.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 05.08.2023.
//

import UIKit

// MARK: - CharacterTableViewCell
final class CharacterTableViewCell: UITableViewCell {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.systemBold(with: 22)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.systemRegular(with: 18)
        return label
    }()
    
    private lazy var starshipsCountLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.systemRegular(with: 18)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            nameLabel,
            genderLabel,
            starshipsCountLabel
        ])
        stack.axis = .vertical
        stack.setCustomSpacing(10, after: nameLabel)
        stack.setCustomSpacing(5, after: genderLabel)
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
        contentView.isUserInteractionEnabled = true
        backgroundColor = .clear
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
    
    func configureCell(
        name: String,
        gender: String,
        starshipsCount: Int,
        isAdded: Bool
    ) {
        isAdded ? addToFavouriteButton.makeAdded() : addToFavouriteButton.makeDefault()
        nameLabel.text = name
        genderLabel.text = "\(R.Strings.gender): \(gender)"
        starshipsCountLabel.text = "\(R.Strings.numberOfStarships): \(starshipsCount)"
    }
}
