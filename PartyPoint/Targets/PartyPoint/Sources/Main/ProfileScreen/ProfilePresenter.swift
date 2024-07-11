//
//  ProfilePresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

final class ProfilePresenter {
	weak var view: ProfileViewInput?
    weak var moduleOutput: ProfileModuleOutput?
    
	private let router: ProfileRouterInput
	private let interactor: ProfileInteractorInput
    
    init(router: ProfileRouterInput, interactor: ProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfilePresenter: ProfileModuleInput {
}

extension ProfilePresenter: ProfileViewOutput {
    func changePasswordActionTapped() {
        interactor.openChangePasswordScreen()
    }
    
    func changeCityActionTapped() {
        let city = interactor.getCurrentCHosenCity()
        router.openChangeCityScreen(with: city)
    }
    
    func exitActionTapped() {
        view?.setLoaderVisibility(isLoading: true)
        interactor.exit()
    }
    
    func onViewDidLoad() {
        interactor.getUser()
    }
    
    func backActionTapped() {
        router.navigateBack()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
    func openChangePasswordScreen(with token: String) {
        router.openChangePasswordScreen(token: token)
    }
    
    func showErrorWhenExit(reason: String) {
        view?.setLoaderVisibility(isLoading: false)
    }
    
    func performSuccessExit() {
        router.exit()
    }
    
    func showUserInfo(info: ProfileInfo) {
        view?.configureView(withInfo: info)
    }
}
