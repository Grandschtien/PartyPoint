//
//  ProfileProtocols.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

protocol ProfileModuleInput {
	var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: AnyObject {
}

protocol ProfileViewInput: AnyObject {
    func configureView(withInfo info: ProfileInfo)
    func setLoaderVisibility(isLoading: Bool)
}

protocol ProfileViewOutput: AnyObject {
    func backActionTapped()
    func exitActionTapped()
    func changePasswordActionTapped()
    func changeCityActionTapped()
    func onViewDidLoad()
}

protocol ProfileInteractorInput: AnyObject {
    func getUser()
    func exit()
    func openChangePasswordScreen()
    func getCurrentCHosenCity() -> String 
}

protocol ProfileInteractorOutput: AnyObject {
    func showUserInfo(info: ProfileInfo)
    func showErrorWhenExit(reason: String)
    func performSuccessExit()
    func openChangePasswordScreen(with token: String)
}

protocol ProfileRouterInput: AnyObject {
    func navigateBack()
    func exit()
    func openChangePasswordScreen(token: String)
    func openChangeCityScreen(with city: String)
}
