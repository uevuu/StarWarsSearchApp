//
//  UITableView+Extensions.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 05.08.2023.
//

import UIKit

extension UITableView {
    func register(_ cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: "\(cellClass.self)")
    }
    
    func dequeueReusableCell<T: UITableViewCell>(
        _ cellClass: T.Type,
        for indexPath: IndexPath
    ) -> T {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: "\(cellClass.self)",
            for: indexPath
        ) as? T else {
            fatalError("Forgot register \(T.self)")
        }
        return cell
    }
}
