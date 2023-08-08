//
//  Resources.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 07.08.2023.
//

import UIKit

// swiftlint:disable type_name
enum R {
    enum Colors {
        static let background = UIColor(named: "background")
        static let selected = UIColor(named: "selected")
        static let secondary = UIColor(named: "secondary")
        static let mainFont = UIColor(named: "mainFont")
    }
    
    enum Strings {
        static let search = "Search"
        static let favourite = "Favourite"
        static let passengersCount = "Passengers count"
        static let gender = "Gender"
        static let manufacturer = "Manufacturer"
        static let population = "Population"
        static let diameter = "Diameter"
        static let numberOfStarships = "Number of starships"
        static let director = "Director"
        static let producer = "Producer"
    }
    
    enum Fonts {
        static func systemRegular(with size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .regular)
        }
        
        static func systemBold(with size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .bold)
        }
    }
    
    enum Image {
        static let magnifyingglass = UIImage(systemName: "magnifyingglass")
        static let star = UIImage(systemName: "star")
        static let starFill = UIImage(systemName: "star.fill")
    }
}
// swiftlint:enable type_name
