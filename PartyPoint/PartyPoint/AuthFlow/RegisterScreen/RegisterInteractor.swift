//
//  RegisterInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import Foundation

final class RegisterInteractor {
    private let authManager: AuthManager
	weak var output: RegisterInteractorOutput?
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
}

extension RegisterInteractor: RegisterInteractorInput {
    func registerUser(with info: [String?]) {
        Task {
            let validateInfo = info.compactMap{$0}
            let response = await authManager.register(with: validateInfo[0],
                                                      surname: validateInfo[1],
                                                      mail: validateInfo[2],
                                                      password: validateInfo[3])
            switch response {
            case .success:
                break
            case let .failure(reason):
                break
            }
        }
    }
}
