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
                                                   checkPasswd: String?,
                                                   image: Data?)) -> Bool {
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
                                                 checkPasswd: String?,
                                                 image: Data?)) -> PPRegisterUserInformation? {
        guard let name = registerInfo.name,
              let surname = registerInfo.surname,
              let email = registerInfo.email,
              let password = registerInfo.passwd,
              let dob = registerInfo.dob
        else
        {
            return nil
        }
        if let finalDate = dobCheck(dob: dob) {
            return PPRegisterUserInformation(name: name,
                                             surname: surname,
                                             email: email,
                                             passwd: password,
                                             dateOfBirth: finalDate,
                                             // TODO: Uncomment when city will be added
                                             // city: city,
                                             imageData: makeImageMedia(data: registerInfo.image))
        } else { return nil }
    }
    
    func makeImageMedia(data: Data?) -> Media {
        if let data = data {
           return Media(withImageData: data, forKey: "image")
        } else {
            return Media(withImageData: Data(), forKey: "image")
        }
    }
    
    func dobCheck(dob: String) -> String? {
        if let normalDate = Date(string: dob) {
            return normalDate.toString(format: "yyyy-MM-dd")
        }
        view?.showThatDateIsIncorrect(reason: PartyPointStrings.Localizable.showDateError)
        return nil
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
                                             checkPasswd: String?,
                                             image: Data?)) {
        
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
    
    func showImagePicker() {
        router.showImagePicker(delegateForPicker: self)
    }
    
    func backButtonPressed() {
        router.routeBack()
    }
}

extension RegisterPresenter: ImagePickerDelegate {
    func didSelect(image: Data?) {
        guard let image = image else { return }
        view?.imageSelected(imageData: image)
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

