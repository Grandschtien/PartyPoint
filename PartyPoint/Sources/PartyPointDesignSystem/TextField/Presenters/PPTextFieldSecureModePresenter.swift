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
        let eyeButton = PPTextFieldRightViewButton()

        func setupRightView(textField: PPTextField) {
            guard textField.isFirstResponder else {
                textField.rightView = textField.displayState.rightView()
                textField.rightViewMode = .always
                return
            }
            
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
            let eyeImage = PartyPointAsset.icInputEye.image
            let eyeCrossedImage = PartyPointAsset.icInputEyeCrossed.image
            let icon = isSecure ? eyeImage : eyeCrossedImage
            button.setImage(icon, for: .normal)
        }
    }
}
