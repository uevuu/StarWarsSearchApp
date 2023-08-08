//
//  UITabBarController+Extensions.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 08.08.2023.
//

import UIKit

extension UITabBarController {
    func addViewController(
        viewController: UIViewController,
        title: String,
        image: UIImage?
    ) {
        viewController.title = title
        viewController.tabBarItem.image = image
        var viewControllers = self.viewControllers ?? []
        viewControllers.append(viewController)
        setViewControllers(viewControllers, animated: true)
    }
}
