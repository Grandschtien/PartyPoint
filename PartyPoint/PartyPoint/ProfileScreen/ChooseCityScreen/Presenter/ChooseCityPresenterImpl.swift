//
//  ChooseCityPresenterImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.05.2023.
//  
//

import Foundation

final class ChooseCityPresenterImpl {
    private weak var view: ChooseCityView?
    private let accountMananger: PPAccountManager
    private var chosenCity: String
    private let notificationCenter = NotificationCenter.default
    
    init(chosenCity: String, accountManager: PPAccountManager) {
        self.chosenCity = chosenCity
        self.accountMananger = accountManager
    }
}

// MARK: Public methods
extension ChooseCityPresenterImpl {
    func setView(_ view: ChooseCityView) {
        self.view = view
    }
}

// MARK: ChooseCityPresenter
extension ChooseCityPresenterImpl: ChooseCityPresenter {
    func viewDidLoad() {
        view?.setCurrentCity(city: chosenCity)
    }
    
    func viewDidDisappear() {
        guard var user = accountMananger.getUser() else { return }
        user.city = chosenCity
        accountMananger.setUser(user: user)
        notificationCenter.post(name: .cityDidChanged, object: nil)
    }
    
    func updateChosenCity(city: String) {
        self.chosenCity = city
    }
}

