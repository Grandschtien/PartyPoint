//
//  MainFlowCoordinator.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit
import PartyPointResources
import PartyPointNavigation

final class MainFlowCoordinator: Coordinator {
    private let window: UIWindow
    private lazy var tabBarController = UITabBarController()
    private lazy var navigationControllers = MainFlowCoordinator.makeNavigationControllers()
    private weak var appCoordinator: AppCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        setupAppearance()
    }
    
    func start() {
        setupEvents()
        setupFavourites()
        setupSearch()
        
        let navigationControllers = NavControllerType.allCases.compactMap {
            self.navigationControllers[$0]
        }
        tabBarController.setViewControllers(navigationControllers, animated: true)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {})
    }
    
    func setAppCoordinator(_ coordinator: AppCoordinator) {
        self.appCoordinator = coordinator
    }
}

private extension MainFlowCoordinator {
    func setupEvents(){
        guard let navController = navigationControllers[.events], let appCoordinator = appCoordinator else {
            fatalError("wtf no Current")
        }
        let context = EventsContext(moduleOutput: nil, appCoordinator: appCoordinator)
        let container = EventsContainer.assemble(with: context)
        navController.setViewControllers([container.viewController], animated: false)
        container.viewController.navigationItem.title = NavControllerType.events.title
    }
    
    func setupFavourites() {
        guard let navController = navigationControllers[.favourites], let appCoordinator = appCoordinator else {
            fatalError("wtf no Search")
        }
                
        let container = FavouriteScreenAssembly.assemble(appCoordinator: appCoordinator)
        navController.setViewControllers([container.viewController], animated: false)
    }
    
    func setupSearch() {
        guard let navController = navigationControllers[.search] else {
            fatalError("wtf no Profile")
        }
        let assembly = SearchScreenAssembly.assemble()
        
        navController.setViewControllers([assembly.viewController], animated: false)
    }
    
    func setupAppearance() {
        if #available(iOS 13, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            navigationBarAppearance.backgroundColor = .clear
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = PartyPointResourcesAsset.mainColor.color
        tabBarController.tabBar.backgroundColor = PartyPointResourcesAsset.mainColor.color
        tabBarController.tabBar.shadowImage = nil
        UITabBarItem.appearance().setTitleTextAttributes(
            [
                .font : PartyPointResourcesFontFamily.SFProDisplay.regular.font(size: 12),
                .foregroundColor: PartyPointResourcesAsset.tabBarBarUnselected.color
            ], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes(
            [
                .font : PartyPointResourcesFontFamily.SFProDisplay.regular.font(size: 12),
                .foregroundColor: PartyPointResourcesAsset.tabBarBarUnselected.color
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
            navigationController.isNavigationBarHidden = false
            result[navControllerKey] = navigationController
        }
        return result
    }
}

fileprivate enum NavControllerType: Int, CaseIterable {
    case events, favourites, search
    
    var title: String {
        switch self {
        case .events:
            return PartyPointResourcesStrings.Localizable.events
        case .favourites:
            return PartyPointResourcesStrings.Localizable.favorites
        case .search:
            return PartyPointResourcesStrings.Localizable.search
        }
    }
    
    var image: UIImage {
        switch self {
        case .events:
            return PartyPointResourcesAsset.wine.image.withRenderingMode(.alwaysOriginal)
        case .favourites:
            return PartyPointResourcesAsset.heartFill.image.withRenderingMode(.alwaysOriginal)
        case .search:
            return PartyPointResourcesAsset.search.image.withRenderingMode(.alwaysOriginal)
        }
    }
    
    var unselectedImage: UIImage {
        switch self {
        case .events:
            return PartyPointResourcesAsset.unselectedWine.image.withRenderingMode(.alwaysOriginal)
        case .favourites:
            return PartyPointResourcesAsset.unselectedHeart.image.withRenderingMode(.alwaysOriginal)
        case .search:
            return PartyPointResourcesAsset.uselectedSearch.image.withRenderingMode(.alwaysOriginal)
        }
    }
}
