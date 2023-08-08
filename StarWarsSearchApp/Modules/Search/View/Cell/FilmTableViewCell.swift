//
//  FilmTableViewCell.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 08.08.2023.
//

import UIKit

// MARK: - FilmTableViewCell
final class FilmTableViewCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.systemBold(with: 22)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.systemRegular(with: 18)
        return label
    }()
    
    private lazy var producerLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.systemRegular(with: 18)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            directorLabel,
            producerLabel
        ])
        stack.axis = .vertical
        stack.setCustomSpacing(10, after: titleLabel)
        stack.setCustomSpacing(5, after: directorLabel)
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
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configureCell(
        title: String,
        director: String,
        producer: String
    ) {
        titleLabel.text = title
        directorLabel.text = "\(R.Strings.director): \(director)"
        producerLabel.text = "\(R.Strings.producer): \(producer)"
    }
}
