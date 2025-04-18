//
//  RegisterProtocols.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import Foundation
import PartyPointDesignSystem

protocol RegisterModuleInput {
	var moduleOutput: RegisterModuleOutput? { get }
}

protocol RegisterModuleOutput: AnyObject {
}

protocol RegisterViewInput: AnyObject {
    func showNameIsEmpty()
    func showSurnameIsEmpty()
    func showEmailIsEmpty()
    func showDobIsEmpty()
    func showPasswdIsEmpty()
    func showCheckPasswdIsEmpty()
    func showToPasswordsIsDifferent()
    func showThatDateIsIncorrect(reason: String)
    func showWhyRegisterFailed(reason: String)
    func showLoadingIfNeeded(isLoading: Bool)
    func imageSelected(imageData: Data)
}

protocol RegisterViewOutput: AnyObject {
    func backButtonPressed()
    func registeButtonPressed(registerInfo: (name: String?,
                                             surname: String?,
                                             email: String?,
                                             dob: String?,
                                             city: String?,
                                             passwd: String?,
                                             checkPasswd: String?,
                                             image: Data?))
    func showCalendarPicker()
    func showImagePicker()
}

protocol RegisterInteractorInput: AnyObject {
    func registerUser(with info: PPRegisterUserInformation)
}

protocol RegisterInteractorOutput: AnyObject {
    func userRegistered()
    func registerFailed(withReason reason: String)
}

protocol RegisterRouterInput: AnyObject {
    func routeBack()
    func startMainFlow()
    func showCalendarPicker()
    func showImagePicker(delegateForPicker delegate: ImagePickerDelegate)
}
