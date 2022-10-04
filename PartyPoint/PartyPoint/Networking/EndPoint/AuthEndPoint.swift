//
//  AuthEndPoint.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.10.2022.
//

import Foundation


enum AuthEndPoint {
    case login(login: String, passwd: String)
    case logout
    case refresh(refreshToken: String)
    case signUp
}


