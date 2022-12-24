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

// MARK: - Private methods -
private extension EnterInteractor {
}

extension EnterInteractor: EnterInteractorInput {
    func enterButtonPressed(email: String, password: String) {
        Task {
            let status = await authManager.login(with: email, password: password)
            switch status {
            case .authorized:
                await runOnMainThread {
                    output?.authorized()
                }
            case let .nonAuthoraized(reason):
                guard let reason = reason else {
                    await runOnMainThread {
                        output?.notAuthorized(withReason: "Somthing goes wrong")
                    }
                    return
                }
                await runOnMainThread {
                    output?.notAuthorized(withReason: reason)
                }
            }
        }
    }
}

