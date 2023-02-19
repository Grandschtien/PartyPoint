//
//  FogotPasswordInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import Foundation

final class FogotPasswordInteractor {
    weak var output: FogotPasswordInteractorOutput?
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
}

private extension FogotPasswordInteractor {
    func performSuccessFlow(email: String) {
        output?.performSuccess(email: email)
    }
    
    func performFailureFlow(reason: String?) {
        guard let reason = reason else {
            output?.performFailure(reason: Localizable.somthing_goes_wrong())
            return
        }
        output?.performFailure(reason: reason)
    }
}

extension FogotPasswordInteractor: FogotPasswordInteractorInput {
    func sendCode(withEmail email: String) {
        Task {
            let status = await authManager.sendCofirmCode(toEmail: email)
            
            await runOnMainThread {
                switch status {
                case .authorized:
                    performSuccessFlow(email: email)
                case let .nonAuthoraized(reason):
                    performFailureFlow(reason: reason)
                }
            }
        }
    }
}
