//
//  PPTesx.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit

extension PPTextFieldMode {
    struct SecureModePresenter: PPTextFieldModePresenterProtocol {

        // MARK: - Public properties

        func setupRightView(textField: PPTextField) {
            guard textField.isFirstResponder else {
                textField.rightView = textField.displayState.rightView()
                textField.rightViewMode = .always
                return
            }
            
            let eyeButton = PPTextFieldRightViewButton()
            setupButtonImage(button: eyeButton,
                             isSecure: textField.isSecureTextEntry)
            eyeButton.touchUpAction = { _ in
                textField.isSecureTextEntry = !textField.isSecureTextEntry
                setupButtonImage(button: eyeButton,
                                 isSecure: textField.isSecureTextEntry)
            }

            textField.rightView = eyeButton
            textField.rightViewMode = .always
        }

        // MARK: - Private properties

        private func setupButtonImage(button: UIButton, isSecure: Bool) {
            let eyeImage = Images.icInputEye()
            let eyeCrossedImage = Images.icInputEyeCrossed()
            let icon = isSecure ? eyeImage : eyeCrossedImage
            button.setImage(icon, for: .normal)
        }
    }
    
    struct SecureModePresenterAnimated: PPTextFieldAnimatedModePresenterProtocol {

        // MARK: - Public properties

        func setupTitleLabel(label: UILabel) {}

        func textFieldDidChange(textField: UITextField) {}

        func setupRightView(textField: UITextField) {
            guard textField.isFirstResponder else {
                return
            }
            
            let eyeButton = PPTextFieldRightViewButton()
            setupButtonImage(button: eyeButton,
                             isSecure: textField.isSecureTextEntry)

            eyeButton.touchUpAction = { _ in
                textField.isSecureTextEntry = !textField.isSecureTextEntry
                setupButtonImage(button: eyeButton,
                                 isSecure: textField.isSecureTextEntry)
            }

            textField.rightView = eyeButton
            textField.rightViewMode = .always
        }

        // MARK: - Private properties

        private func setupButtonImage(button: UIButton, isSecure: Bool) {
            let eyeImage = Images.icInputEye()
            let eyeCrossedImage = Images.icInputEyeCrossed()
            let icon = isSecure ? eyeImage : eyeCrossedImage
            button.setImage(icon, for: .normal)
        }
    }
}
