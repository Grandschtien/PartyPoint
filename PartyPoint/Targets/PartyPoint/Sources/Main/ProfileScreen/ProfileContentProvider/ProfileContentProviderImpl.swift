//
//  ProfileContentProviderImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import Foundation

final class ProfileContentProviderImpl: ProfileContentProvider {
    private let user: ProfileInfo
    
    init(user: ProfileInfo) {
        self.user = user
    }
    
    func getUser() -> ProfileInfo {
        return user
    }
}
