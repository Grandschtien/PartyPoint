//
//  AcceptPassswordView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.02.2023.
//

import Foundation

protocol AcceptPassswordView: AnyObject {
    func showError(reason: String)
    func performSuccess(email: String)
    func showLoader(isLoading: Bool)
}
