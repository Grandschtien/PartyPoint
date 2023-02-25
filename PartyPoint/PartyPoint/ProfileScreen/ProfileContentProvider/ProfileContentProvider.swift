//
//  ProfileContentProvider.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import Foundation

protocol ProfileContentProvider {
    func getUser() -> ProfileInfo
}
