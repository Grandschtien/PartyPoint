//
//  ChangePasswordPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.02.2023.
//  
//

import Foundation

protocol ChangePasswordPresenter: AnyObject {
    func sendNewPassword(password: String?, checkPassword: String?)
}

