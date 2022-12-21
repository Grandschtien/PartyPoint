//
//  PPTextFieldDefaultPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit

extension PPTextFieldMode {
    struct DefaultPresenter: PPTextFieldModePresenterProtocol {
        
        // MARK: - Public properties
        
        func setupRightView(textField: PPTextField) {
            guard textField.isFirstResponder else {
                if let stateRightView = textField.displayState.rightView() {
                    textField.rightView = stateRightView
                } else {
                    textField.rightView = textField.customRightView
                }
                
                textField.rightViewMode = .always
                return
            }
            
            if let customRightView = textField.customRightView {
                textField.rightView = customRightView
                textField.rightViewMode = .always
                return
            }
        }
    }
}
