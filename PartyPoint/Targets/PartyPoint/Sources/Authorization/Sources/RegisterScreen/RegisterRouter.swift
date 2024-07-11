//
//  RegisterRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit
import PartyPointNavigation
import PartyPointDesignSystem

final class RegisterRouter: BaseRouter {
    private let mainFlowCoordinator: Coordinator
    private var imagePicker: ImagePicker?
    
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
    
    func showImagePicker(delegateForPicker delegate: ImagePickerDelegate) {
        guard let viewController = currentViewController else { return }
        imagePicker = ImagePicker(presentationController: viewController, delegate: delegate)
        imagePicker?.present(from: viewController.view)
    }
}

