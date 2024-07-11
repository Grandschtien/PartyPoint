//
//  FogotPasswordInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import Foundation
import PartyPointResources

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
            output?.performFailure(reason: PartyPointResourcesStrings.Localizable.somthingGoesWrong)
            return
        }
        output?.performFailure(reason: reason)
    }
}

extension FogotPasswordInteractor: FogotPasswordInteractorInput {
    func sendCode(withEmail email: String) {
        Task { @MainActor in
            let status = await authManager.sendCofirmCode(toEmail: email)
            
            switch status {
            case .success:
                performSuccessFlow(email: email)
            case let .failure(reason):
                performFailureFlow(reason: reason)
            }
        }
    }
}
