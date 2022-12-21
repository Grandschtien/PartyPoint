//
//  PPTextFieldClearModePresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit

extension PPTextFieldMode {
    
    struct ClearModePresenter: PPTextFieldModePresenterProtocol {
        
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
            
            guard !textField.isEmpty else {
                return
            }
            
            let clearButton = PPTextFieldRightViewButton()
            let clearImage = Images.icInputClear()
            clearButton.setImage(clearImage, for: .normal)
            
            clearButton.touchUpAction = { _ in
                let shouldClear = textField.delegate?.textFieldShouldClear?(textField) ?? true
                if shouldClear {
                    textField.text = nil
                    textField.sendActions(for: .editingChanged)
                }
            }
            
            textField.rightView = clearButton
            textField.rightViewMode = .always
        }
        
        func textFieldDidChange(textField: PPTextField) {
            guard textField.isFirstResponder else {
                return
            }
            
            if textField.isEmpty {
                textField.rightView = nil
            } else if textField.rightView == nil {
                setupRightView(textField: textField)
            }
        }
    }
    
    struct ClearModePresenterAnimated: PPTextFieldAnimatedModePresenterProtocol {
        
        // MARK: - Public properties
        
        func setupTitleLabel(label: UILabel) {}
        
        func setupRightView(textField: UITextField) {
            guard textField.isFirstResponder else {
                return
            }
            
            let clearButton = PPTextFieldRightViewButton()
            let clearImage = Images.icInputClear()
            clearButton.setImage(clearImage, for: .normal)
            
            clearButton.touchUpAction = { _ in
                let shouldClear = textField.delegate?.textFieldShouldClear?(textField) ?? true
                if shouldClear {
                    textField.text = nil
                    textField.sendActions(for: .editingChanged)
                }
            }
            
            textField.rightView = clearButton
            textField.rightViewMode = .always
        }
        
        func textFieldDidChange(textField: UITextField) {
            guard textField.isFirstResponder else {
                return
            }
            
            if (textField.text ?? "").isEmpty {
                textField.rightView = nil
            } else if textField.rightView == nil {
                setupRightView(textField: textField)
            }
        }
    }
}
