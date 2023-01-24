//
//  RegisterPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import Foundation

final class RegisterPresenter {
	weak var view: RegisterViewInput?
    weak var moduleOutput: RegisterModuleOutput?
    
	private let router: RegisterRouterInput
	private let interactor: RegisterInteractorInput
    
    init(router: RegisterRouterInput, interactor: RegisterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: Private extension
private extension RegisterPresenter {
    func hasEmptyRequiredTextFields(registerInfo: (name: String?,
                                             surname: String?,
                                             email: String?,
                                             dob: String?,
                                             city: String?,
                                             passwd: String?,
                                             checkPasswd: String?)) -> Bool {
        var hasEmptyRequiredTextFields = false
        
        if let name = registerInfo.name, name.isEmpty {
            hasEmptyRequiredTextFields = true
            view?.showNameIsEmpty()
        }
        
        if let surname = registerInfo.surname, surname.isEmpty {
            hasEmptyRequiredTextFields = true
            view?.showSurnameIsEmpty()
        }
        
        if let email = registerInfo.email, email.isEmpty {
            hasEmptyRequiredTextFields = true
            view?.showEmailIsEmpty()
        }
        
        if let dob = registerInfo.dob, dob.isEmpty {
            hasEmptyRequiredTextFields = true
            view?.showDobIsEmpty()
        }
        
        if let passwd = registerInfo.passwd, passwd.isEmpty {
            hasEmptyRequiredTextFields = true
            view?.showPasswdIsEmpty()
        }
        
        if let checkPasswd = registerInfo.checkPasswd, checkPasswd.isEmpty {
            hasEmptyRequiredTextFields = true
            view?.showCheckPasswdIsEmpty()
        }
        
        return hasEmptyRequiredTextFields
    }
    
    func makeUserInformationModel(registerInfo: (name: String?,
                                                 surname: String?,
                                                 email: String?,
                                                 dob: String?,
                                                 city: String?,
                                                 passwd: String?,
                                                 checkPasswd: String?)) -> PPRegisterUserInformation? {
        guard let name = registerInfo.name,
              let surname = registerInfo.surname,
              let email = registerInfo.email,
              let password = registerInfo.passwd,
              let dob = registerInfo.dob,
              let date = Date(string: dob),
              let city = registerInfo.city else
        { return nil }
        return PPRegisterUserInformation(name: name,
                                         surname: surname,
                                         email: email,
                                         passwd: password,
                                         dateOfBirth: date,
                                         city: city,
                                         imageData: nil)
    }
}

extension RegisterPresenter: RegisterModuleInput {
}

extension RegisterPresenter: RegisterViewOutput {
    func registeButtonPressed(registerInfo: (name: String?,
                                             surname: String?,
                                             email: String?,
                                             dob: String?,
                                             city: String?,
                                             passwd: String?,
                                             checkPasswd: String?)) {
        let hasEmptyRequiredTextFields = hasEmptyRequiredTextFields(registerInfo: registerInfo)
        let isPsswordsMatch = registerInfo.passwd == registerInfo.checkPasswd
        
        if hasEmptyRequiredTextFields {
            return
        }
        
        if !isPsswordsMatch {
            view?.showToPasswordsIsDifferent()
            return
        }
        
        view?.showLoadingIfNeeded(isLoading: true)
        let userInformation = makeUserInformationModel(registerInfo: registerInfo)
        guard let userInformation = userInformation else {
            view?.showLoadingIfNeeded(isLoading: false)
            return
        }
        interactor.registerUser(with: userInformation)
    }
    
    func showCalendarPicker() {
        router.showCalendarPicker()
    }
    
    func backButtonPressed() {
        router.routeBack()
    }
}

extension RegisterPresenter: RegisterInteractorOutput {
    func userRegistered() {
        view?.showLoadingIfNeeded(isLoading: false)
        router.startMainFlow()
    }
    
    func registerFailed(withReason reason: String) {
        view?.showLoadingIfNeeded(isLoading: false)
        view?.showWhyRegisterFailed(reason: reason)
    }
}
