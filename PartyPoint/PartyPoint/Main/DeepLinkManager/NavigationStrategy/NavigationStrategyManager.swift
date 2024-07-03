//
//  NavigationStrategyManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.05.2023.
//

import Foundation

final class NavigationStrategyManager {
    private let strategy: NavigationStrategy
    
    init(strategy: NavigationStrategy) {
        self.strategy = strategy
    }
    
    func performStrategy() {
        strategy.openScreen()
    }
}
