//
//  ChangePasswordView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.02.2023.
//  
//

protocol ChangePasswordView: AnyObject {
    func showError(reason: String)
    func showEmptyFileds()
    func showLoading(isLoading: Bool)
    func performSuccess()
}
