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
    func openChangePasswordScreen(token: String) {
        let assembly = ChangePasswordAssembly.assemble(creditail: token, state: .profile)
        self.push(vc: assembly.viewController, animated: true)
    }
    
    func openChangeCityScreen() {
        let assembly = ChooseCityAssembly.assemble()
        self.present(vc: assembly.viewController, animated: true)
    }
    
    func navigateBack() {
        pop(animated: true)
    }
    
    func exit() {
        appCoornator.exit()
    }
}
