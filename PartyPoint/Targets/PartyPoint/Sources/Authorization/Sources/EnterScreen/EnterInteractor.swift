//
//  EnterInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation
import PartyPointCore
import PartyPointResources

final class EnterInteractor {
    weak var output: EnterInteractorOutput?
    private let authManager: AuthManager
    private let validationTokenMananger: ValidationTokenManager
    private let accountManager: PPAccountManager
    private let locationManager: LocationManager
    private let userDefaultsManager: UserDefaultsManager
    
    init(authManager: AuthManager,
         validationTokenMananger: ValidationTokenManager,
         accountManager: PPAccountManager,
         locationManager: LocationManager,
         userDefaultsManager: UserDefaultsManager) {
        self.authManager = authManager
        self.validationTokenMananger = validationTokenMananger
        self.accountManager = accountManager
        self.locationManager = locationManager
        self.userDefaultsManager = userDefaultsManager
    }
}

// MARK: - Private methods -
private extension EnterInteractor {
    @MainActor
    func saveTokens(_ tokens: PPToken) async {
        do {
            try validationTokenMananger.saveTokens(tokens)
        } catch {
            output?.notAuthorized(withReason: PartyPointResourcesStrings.Localizable.somthingGoesWrong)
        }
    }
    
    @MainActor
    func performNonAthorizedFlow(withReason reason: String?) async {
        guard let reason = reason else {
            output?.notAuthorized(withReason: PartyPointResourcesStrings.Localizable.somthingGoesWrong)
            return
        }
            
        output?.notAuthorized(withReason: reason)
    }
    
    @MainActor
    func performAuthorizedFlow(withData data: Data?, email: String) async {
        let userInfo = accountManager.parseUserInformation(data: data)
        guard let userInfo = userInfo  else {
            output?.notAuthorized(withReason: PartyPointResourcesStrings.Localizable.somthingGoesWrong)
            return
        }
        
        accountManager.setUser(user: userInfo.user)
        userDefaultsManager.setIsLogged(true)
        await saveTokens(userInfo.tokens)
        output?.authorized()
    }
}

extension EnterInteractor: EnterInteractorInput {
    func requestLocationPermission() {
        locationManager.requestPermission()
    }
    
    func enterButtonPressed(email: String, password: String) {
        Task {
            let status = await authManager.login(with: email, password: password)
            switch status {
            case let .success(data):
                await performAuthorizedFlow(withData: data, email: email)
            case let .failure(reason):
                await performNonAthorizedFlow(withReason: reason)
            }
        }
    }
}

