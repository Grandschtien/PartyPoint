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
    func onViewDidLoad()
}

protocol ProfileInteractorInput: AnyObject {
    func getUser()
    func exit()
}

protocol ProfileInteractorOutput: AnyObject {
    func showUserInfo(info: ProfileInfo)
    func showErrorWhenExit(reason: String)
    func performSuccessExit()
    func showErrorWhenAccountDelete(reason: String)
    func preformSuccessAccountRemoving()
}

protocol ProfileRouterInput: AnyObject {
    func navigateBack()
    func exit()
}
