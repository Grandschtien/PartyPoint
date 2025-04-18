//
//  ChangePasswordContentView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.02.2023.
//  
//

import SnapKit
import UIKit
import PartyPointDesignSystem
import PartyPointResources
import PartyPointCore

private let TITLE_LABEL_TOP_OFFSET: CGFloat = 15
private let TITLE_LABEL_HORIZONTAL_OFFSET: CGFloat = 33
private let TITLE_LABEL_FONT_SIZE: CGFloat = 30.scale()
private let STACK_HORIZONTAL_OFFSET: CGFloat = 33
private let STACK_TOP_OFFSET: CGFloat = 35
private let CONFIRM_BUTTON_TOP_OFFSET: CGFloat = 65.scale()
private let CONFIRM_BUTTON_HORIZONTAL_OFFSET: CGFloat = 33
private let CONFIRM_BUTTON_HEIGHT: CGFloat = 56.scale()

final class ChangePasswordContentView: UIView {
    typealias SendNewPasswordAction = (String?, String?) -> Void
    
    private var sendAction: SendNewPasswordAction?
    
    // MARK: Private properties
    private let navigationBar = NavigationBarWithLogoAndActions(frame: .zero, buttons: [.back])
    private let titleLabel = UILabel()
    private let textFieldStack = DynamicStackWithTF(placeholders: [
        PartyPointResourcesStrings.Localizable.passwordTitleRegistration,
        PartyPointResourcesStrings.Localizable.checkPasswordTitleRegistration
    ])
    private let confirmButton = PPButton(style: .primary, size: .l)
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: Private methods
private extension ChangePasswordContentView {
    func setupUI() {
        self.backgroundColor = PartyPointResourcesAsset.mainColor.color
        self.addSubview(navigationBar)
        self.addSubview(titleLabel)
        self.addSubview(textFieldStack)
        self.addSubview(confirmButton)
        
        setupTitleLabel()
        setupTextFields()
        setupConfirmButton()
        
        setupConstraints()
    }
    
    func setupConstraints() {
        navigationBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.snp.top).offset(statusBarFrame.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(TITLE_LABEL_TOP_OFFSET)
            $0.left.right.equalToSuperview().inset(TITLE_LABEL_HORIZONTAL_OFFSET)
        }
        
        textFieldStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(STACK_TOP_OFFSET)
            $0.left.right.equalToSuperview().inset(STACK_HORIZONTAL_OFFSET)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(textFieldStack.snp.bottom).offset(CONFIRM_BUTTON_TOP_OFFSET)
            $0.left.right.equalToSuperview().inset(CONFIRM_BUTTON_HORIZONTAL_OFFSET)
            $0.height.equalTo(CONFIRM_BUTTON_HEIGHT)
        }
    }
    
    
    func setupTitleLabel() {
        titleLabel.text = PartyPointResourcesStrings.Localizable.insertNewPassword
        titleLabel.font = PartyPointResourcesFontFamily.SFProDisplay.semibold.font(size: TITLE_LABEL_FONT_SIZE)
        titleLabel.numberOfLines = 2
    }
    
    func setupTextFields() {
        textFieldStack.textFields.forEach {
            $0.mode = .secureMode
            $0.isSecureTextEntry = true
        }
    }
    
    func setupConfirmButton() {
        confirmButton.setTitle(PartyPointResourcesStrings.Localizable.changePassword, for: .normal)
        confirmButton.addTarget(self, action: #selector(sendNewPasswordActionHandler),
                                for: .touchUpInside)
    }
}

// MARK: Public methods
extension ChangePasswordContentView {
    func setSendNewPasswordAction(_ action: @escaping SendNewPasswordAction) {
        self.sendAction = action
    }
    
    func setBackAction(_ action: @escaping (() -> Void)) {
        self.navigationBar.setBackAction(action)
    }
    
    func setIsLoading(isLoading: Bool) {
        confirmButton.isLoading = isLoading
    }
    
    func showTextFieldsIsEmpty() {
        textFieldStack.textFields.forEach {
            $0.displayState = .error(PartyPointResourcesStrings.Localizable.fillInThisField)
        }
    }
    
    func showError(reason: String) {
        textFieldStack.textFields[1].displayState = .error(reason)
    }
    
    func showEmptyFields() {
        textFieldStack.textFields.forEach { field in
            if let text = field.text, text.isEmpty {
                field.displayState = .error(PartyPointResourcesStrings.Localizable.fillInThisField)
            }
        }
    }
}

// MARK: Actions
extension ChangePasswordContentView {
    @objc
    func sendNewPasswordActionHandler() {
        sendAction?(textFieldStack.textFields[0].text, textFieldStack.textFields[1].text)
    }
}


