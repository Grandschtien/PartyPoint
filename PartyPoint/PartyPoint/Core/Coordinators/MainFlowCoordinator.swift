//
//  MainFlowCoordinator.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

final class MainFlowCoordinator: Coordinator {
    private let window: UIWindow
    private lazy var tabBarController = UITabBarController()
    private lazy var navigationControllers = MainFlowCoordinator.makeNavigationControllers()
    
    init(window: UIWindow) {
        self.window = window
        setupAppearance()
    }
    
    func start() {
        setupEvents()
        setupFavourites()
        setupProfile()
        
        let navigationControllers = NavControllerType.allCases.compactMap {
            self.navigationControllers[$0]
        }
        tabBarController.setViewControllers(navigationControllers, animated: true)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {})
    }
}

private extension MainFlowCoordinator {
    func setupEvents(){
        guard let navController = navigationControllers[.events] else {
            fatalError("wtf no Current")
        }
        let context = EventsContext(moduleOutput: nil)
        let container = EventsContainer.assemble(with: context)
        navController.setViewControllers([container.viewController], animated: false)
        container.viewController.navigationItem.title = NavControllerType.events.title
    }
    
    func setupFavourites() {
        guard let navController = navigationControllers[.favourites] else {
            fatalError("wtf no Search")
        }
        
        let context = FavouritesContext(moduleOutput: nil)
        
        let container = FavouritesContainer.assemble(with: context)
        navController.setViewControllers([container.viewController], animated: false)
    }
    
    func setupProfile() {
        guard let navController = navigationControllers[.profile] else {
            fatalError("wtf no Profile")
        }
        let context = ProfileContext(moduleOutput: nil)
        
        let container = ProfileContainer.assemble(with: context)
        navController.setViewControllers([container.viewController], animated: false)
    }
    
    func setupAppearance() {
        if #available(iOS 13, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            navigationBarAppearance.backgroundColor = Colors.mainColor()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = Colors.mainColor()
        tabBarController.tabBar.backgroundColor = Colors.mainColor()
        tabBarController.tabBar.shadowImage = nil
        UITabBarItem.appearance().setTitleTextAttributes(
            [
                .font : Fonts.sfProDisplayRegular(size: 12)!,
                .foregroundColor: Colors.tabBarBarUnselected()!
            ], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes(
            [
                .font : Fonts.sfProDisplayRegular(size: 12)!,
                .foregroundColor: Colors.tabBarBarUnselected()!
            ], for: .normal)
    }
    
    static func makeNavigationControllers() -> [NavControllerType: UINavigationController] {
        var result: [NavControllerType: UINavigationController] = [:]
        NavControllerType.allCases.forEach { navControllerKey in
            let navigationController = UINavigationController()
            let tabBarItem = UITabBarItem(title: navControllerKey.title,
                                          image: navControllerKey.unselectedImage,
                                          selectedImage: navControllerKey.image)
            
            navigationController.tabBarItem = tabBarItem
            UINavigationBar.appearance().barTintColor = Colors.mainColor()
            UINavigationBar.appearance().backgroundColor = Colors.mainColor()
            result[navControllerKey] = navigationController
        }
        return result
    }
}

fileprivate enum NavControllerType: Int, CaseIterable {
    case events, favourites, profile
    
    var title: String {
        switch self {
        case .events:
            return Localization.currentTournaments
        case .favourites:
            return Localization.search
        case .profile:
            return Localization.profile
        }
    }
    
    var image: UIImage? {
        switch self {
        case .events:
            return Images.wine()?.withRenderingMode(.alwaysOriginal)
        case .favourites:
            return Images.heartFill()?.withRenderingMode(.alwaysOriginal)
        case .profile:
            return Images.person()?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    var unselectedImage: UIImage? {
        switch self {
        case .events:
            return Images.unselectedWine()?.withRenderingMode(.alwaysOriginal)
        case .favourites:
            return Images.unselectedHeart()?.withRenderingMode(.alwaysOriginal)
        case .profile:
            return Images.unselectedPerson()?.withRenderingMode(.alwaysOriginal)
        }
    }
}


enum Localization {
    static let currentTournaments = "Мероприятия"
    static let search = "Избранное"
    static let profile = "Профиль"
}
