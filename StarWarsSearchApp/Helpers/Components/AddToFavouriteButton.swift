//
//  AddToFavouriteButton.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 08.08.2023.
//

import UIKit

// MARK: - AddToFavouriteButton
final class AddToFavouriteButton: UIButton {
    private lazy var starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(starImage)
    }
    
    private func setConstraints() {
        starImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func makeAdded() {
        starImage.image = UIImage(systemName: "star.fill")
        starImage.tintColor = .yellow
    }
    
    func makeDefault() {
        starImage.image = UIImage(systemName: "star")
        starImage.tintColor = .black
    }
}
