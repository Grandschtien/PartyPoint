//
//  EnterInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

final class EnterInteractor {
    weak var output: EnterInteractorOutput?
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
}

extension EnterInteractor: EnterInteractorInput {
    func enterButtonPressed(email: String, password: String) async {
        let status = await authManager.login(with: email, password: password)
        switch status {
        case .authorized:
            output?.authorized()
        case let .nonAuthoraized(error):
            output?.notAuthorized(error: error)
        }
    }
}
