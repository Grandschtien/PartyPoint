//
//  PPRegisterUserInformation.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 07.01.2023.
//

import Foundation

struct PPRegisterUserInformation {
    let name: String
    let surname: String
    let email: String
    let passwd: String
    let dateOfBirth: Date
    let city: String?
    let imageData: Data?
}
