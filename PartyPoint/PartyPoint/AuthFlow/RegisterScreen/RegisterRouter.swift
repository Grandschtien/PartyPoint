//
//  RegisterRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit

final class RegisterRouter: BaseRouter {
    private let mainFlowCoordinator: Coordinator
    
    init(mainFlowCoordinator: Coordinator) {
        self.mainFlowCoordinator = mainFlowCoordinator
        super.init()
    }
}

extension RegisterRouter: RegisterRouterInput {
    func startMainFlow() {
        mainFlowCoordinator.start()
    }
    
    func routeBack() {
        pop(animated: true)
    }
    func showCalendarPicker() {
        let pickerController = CalendarPickerViewController(baseDate: Date()) { date in
            print(date)
        }
        
        present(vc: pickerController, animated: true)
    }
}

