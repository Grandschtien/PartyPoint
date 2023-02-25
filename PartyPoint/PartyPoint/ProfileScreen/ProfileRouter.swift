//
//  ProfileRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class ProfileRouter: BaseRouter {
    private let appCoornator: AppCoordinator
    
    init(appCoornator: AppCoordinator) {
        self.appCoornator = appCoornator
    }
}

extension ProfileRouter: ProfileRouterInput {
    func navigateBack() {
        pop(animated: true)
    }
    
    func exit() {
        appCoornator.exit()
    }
}
