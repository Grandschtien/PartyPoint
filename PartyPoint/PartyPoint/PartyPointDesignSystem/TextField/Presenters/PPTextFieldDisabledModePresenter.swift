//
//  PPTextFieldReadOnlyModePresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit

extension PPTextFieldMode {
    struct DisabledModePresenter: PPTextFieldModePresenterProtocol {
        
        // MARK: - Constants
        
        enum Constants {
            static let copiedText = "Текст скопирован"
        }
        
        // MARK: - Properties
        let copyButton = PPTextFieldRightViewButton()
        let infoText: String?
        
        // MARK: - MTSTextFieldModePresenterProtocol
        
        func setupTitleLabel(label: UILabel) {
            label.addLockerIcon(iconColor: label.textColor)
        }
        
        func setupRightView(textField: PPTextField) {
            textField.endEditing(true)
            
            if textField.isEmpty {
                setupEmptyTextRightView(textField: textField)
            } else {
                setupFilledTextRightView(textField: textField)
            }
        }
        
        func textFieldCanBecomeFirstResponder() -> Bool {
            return false
        }
        
        // MARK: - Private methods
        
        private func setupFilledTextRightView(textField: UITextField) {
            let copyImage = R.image.icInputCopyText()
            copyButton.setImage(copyImage, for: .normal)
            
            copyButton.touchUpAction = { _ in
                UIPasteboard.general.string = textField.text
                let message = PPToastData(title: nil,
                                          text: Constants.copiedText,
                                          icon: .done)
                PPToast.show(message)
            }
            
            textField.rightView = copyButton
            textField.rightViewMode = .always
        }
        
        func setupEmptyTextRightView(textField: PPTextField) {
            
            let infoButton = PPTextFieldRightViewButton()
            let copyImage = R.image.icInputInfo()
            infoButton.setImage(copyImage, for: .normal)
            
            textField.rightView = infoButton
            textField.rightViewMode = .always
        }
    }
}
