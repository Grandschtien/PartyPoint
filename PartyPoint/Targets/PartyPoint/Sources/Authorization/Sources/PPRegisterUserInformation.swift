//
//  PPRegisterUserInformation.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 07.01.2023.
//

import Foundation
import PartyPointNetworking

public struct PPRegisterUserInformation {
    let name: String
    let surname: String
    let email: String
    let passwd: String
    let dateOfBirth: String
    let imageData: Media
}
