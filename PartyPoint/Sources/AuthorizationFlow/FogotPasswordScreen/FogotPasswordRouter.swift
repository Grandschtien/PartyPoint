//
//  FogotPasswordRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit

final class FogotPasswordRouter: BaseRouter {}

extension FogotPasswordRouter: FogotPasswordRouterInput {
    func routeBack() {
        pop(animated: true)
    }
    
    func openSendCodeScreen(with email: String) {
        let assembly = AcceptPasswordAssebly.assemble(email: email)
        push(vc: assembly.viewController, animated: true)
    }
}
