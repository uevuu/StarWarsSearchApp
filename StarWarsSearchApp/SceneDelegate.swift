//
//  SceneDelegate.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 05.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let favService = FavouriteServiceImpl()
        let searchPresenter = SearchPresenter(
            charactersNetworkService: CharactersNetworkServiceImpl(),
            starshipsNetworkService: StarshipsNetworkServiceImpl(),
            planetsNetworkService: PlanetsNetworkServiceImpl(),
            filmsNetworkService: FilmsNetworkServiceImpl(),
            favouriteService: favService
        )
        let searchViewController = SearchViewController(output: searchPresenter)
        searchPresenter.view = searchViewController
        let tabBar = UITabBarController()
        tabBar.addViewController(
            viewController: UINavigationController(rootViewController: searchViewController),
            title: R.Strings.search,
            image: R.Image.magnifyingglass
        )
        let favouritePresenter = FavouritePresenter(favouriteService: favService)
        let favouriteViewController = FavouriteViewController(output: favouritePresenter)
        favouritePresenter.view = favouriteViewController
        tabBar.addViewController(
            viewController: UINavigationController(rootViewController: favouriteViewController),
            title: R.Strings.favourite,
            image: R.Image.star
        )
        window.rootViewController = UINavigationController(rootViewController: tabBar)
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
