//
//  EnterView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.11.2022.
//

import SnapKit
import UIKit
import PartyPointDesignSystem
import PartyPointResources

private let ENTRY_LABEL_HORIZONTAL_OFFSETS: CGFloat = 42
private let ENTRY_LABEL_HEIGHT: CGFloat = 108.scale()
private let ENTRY_LABEL_WIDTH: CGFloat = 180.scale()
private let ENTRY_LABEL_TOP_OFFSET: CGFloat = 50
private let TF_STACK_HORIZONTAL_OFFSETS: CGFloat = 15
private let TF_STACK_TOP_OFFSET: CGFloat = 35
private let FORGOT_PASSWORD_BUTTON_WIDTH: CGFloat = 120.scale()
private let FORGOT_PASSWORD_BUTTON_TOP_OFFSET: CGFloat = 25
private let FORGOT_PASSWORD_BUTTON_HEIGHT: CGFloat = 17
private let HOW_TO_ENTER_STACK_HORIZONTAL_OFFSETS: CGFloat = 30
private let HOW_TO_ENTER_STACK_TOP_OFFSET: CGFloat = 110

final class EnterView: UIView {
    typealias EnterAction = ((String, String) -> Void)
    
    private var enterAction: ((String, String) -> Void)?
    private var registerAction: (() -> Void)?
    private var forgotPasswordAction: (() -> Void)?
    
    private let entryLabel = UILabel()
    private var tfStack: DynamicStackWithTF?
    private let forgotPaaswdButton = UIButton()
    private let howToEnterStack = HowToEnterStackView()
    
    private var topTobottomConstraintOfEntryLabel: Constraint?
    private var topTobottomConstraintOfButton: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setEnterAction(_ action: @escaping EnterAction) {
        enterAction = action
    }
    
    
    func setRegisterAction(_ action: @escaping (() -> Void)) {
        registerAction = action
    }
    
    
    func setForgotPasswordAction(_ action: @escaping (() -> Void)) {
        forgotPasswordAction = action
    }
    
    func showTFIsEmptyView() {
        loginTFIsEmpty()
        passwordTFIsEmpty()
    }
    
    func loginTFIsEmpty() {
        tfStack?.textFields[0].displayState = .error(PartyPointResourcesStrings.Localizable.fillInThisField)
    }
    
    func passwordTFIsEmpty() {
        tfStack?.textFields[1].displayState = .error(PartyPointResourcesStrings.Localizable.fillInThisField)
    }
    
    func showUnauthorizeReason(reason: String) {
        tfStack?.textFields[1].subtitleText = reason
    }
    
    func setLoadingVisible() {
        howToEnterStack.setLoadingVisible()
    }
    
    func setLoadingHide() {
        howToEnterStack.setLoadingHide()
    }
}

private extension EnterView {
    func setupUI() {
        self.backgroundColor = PartyPointResourcesAsset.mainColor.color
        self.addTapRecognizer(target: self, action: #selector(endEnditing))
        self.howToEnterStack.delegate = self
        
        setupTfStack()
        setupEntryLabel()
        setupForgotPaaswdButton()
        
        self.addSubview(entryLabel)
        
        if let tfStack = tfStack {
            self.addSubview(tfStack)
        }
        
        self.addSubview(forgotPaaswdButton)
        self.addSubview(howToEnterStack)
        setupConstraints()
    }
    
    func setupConstraints() {
        entryLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(ENTRY_LABEL_HORIZONTAL_OFFSETS.scale())
            $0.width.equalTo(ENTRY_LABEL_WIDTH.scale())
            $0.height.equalTo(ENTRY_LABEL_HEIGHT.scale())
            topTobottomConstraintOfEntryLabel = $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(ENTRY_LABEL_TOP_OFFSET.scale()).constraint
        }
        
        tfStack?.snp.makeConstraints {
            $0.left.equalToSuperview().offset(TF_STACK_HORIZONTAL_OFFSETS.scale())
            $0.right.equalToSuperview().inset(TF_STACK_HORIZONTAL_OFFSETS.scale())
            $0.top.equalTo(entryLabel.snp.bottom).offset(TF_STACK_TOP_OFFSET.scale())
        }
        
        if let tfStack = tfStack {
            forgotPaaswdButton.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(tfStack.snp.bottom).offset(FORGOT_PASSWORD_BUTTON_TOP_OFFSET.scale())
                $0.height.equalTo(FORGOT_PASSWORD_BUTTON_HEIGHT.scale())
            }
        }
        
        howToEnterStack.snp.makeConstraints {
            $0.left.equalToSuperview().offset(HOW_TO_ENTER_STACK_HORIZONTAL_OFFSETS.scale())
            $0.right.equalToSuperview().inset(HOW_TO_ENTER_STACK_HORIZONTAL_OFFSETS.scale())
            topTobottomConstraintOfButton = $0.top.equalTo(forgotPaaswdButton.snp.bottom).offset(HOW_TO_ENTER_STACK_TOP_OFFSET.scale()).constraint
        }
    }
    
    func setupEntryLabel() {
        entryLabel.font = PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: 30.scale())
        entryLabel.numberOfLines = 3
        entryLabel.text = PartyPointResourcesStrings.Localizable.entryLabel
    }
    
    func setupTfStack() {
        let placeholders: [String] = [
            PartyPointResourcesStrings.Localizable.emailTitleRegistration,
            PartyPointResourcesStrings.Localizable.passwordTitleRegistration
        ]
        tfStack = DynamicStackWithTF(frame: .zero, placeholders: placeholders)
        tfStack?.textFields[0].mode = .clearMode
        tfStack?.textFields[1].mode = .secureMode
        tfStack?.textFields[1].isSecureTextEntry = true
    }
    
    func setupForgotPaaswdButton() {
        forgotPaaswdButton.setTitle(PartyPointResourcesStrings.Localizable.forgotPasswordButtonTitle, for: .normal)
        forgotPaaswdButton.titleLabel?.font = PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: 14.scale())
        forgotPaaswdButton.titleLabel?.textColor = PartyPointResourcesAsset.mainColor.color.withAlphaComponent(0.75)
        forgotPaaswdButton.backgroundColor = .clear
        forgotPaaswdButton.addTarget(self, action: #selector(fogotButtonPressed), for: .touchUpInside)
    }
}

//MARK: - Keyboard observer -
extension EnterView {
    func keyboardWillShow() {
        if topTobottomConstraintOfEntryLabel?.layoutConstraints[0].constant == ENTRY_LABEL_TOP_OFFSET.scale() {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.topTobottomConstraintOfEntryLabel?.layoutConstraints[0].constant -= FORGOT_PASSWORD_BUTTON_WIDTH.scale()
                self?.topTobottomConstraintOfButton?.layoutConstraints[0].constant -= ENTRY_LABEL_TOP_OFFSET.scale()
                self?.layoutIfNeeded()
            }
        }
    }
    
    func keyboardWillHide() {
        if topTobottomConstraintOfEntryLabel?.layoutConstraints[0].constant ?? 0 <= -70.scale() {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.topTobottomConstraintOfEntryLabel?.layoutConstraints[0].constant += FORGOT_PASSWORD_BUTTON_WIDTH.scale()
                self?.topTobottomConstraintOfButton?.layoutConstraints[0].constant += ENTRY_LABEL_TOP_OFFSET.scale()
                self?.layoutIfNeeded()
            }
        }
    }
}

//MARK: - Actions -
extension EnterView: HowToEnterStackViewDelegate {
    func enterButtonPressed() {
        if let login = tfStack?.textFields[0].text,
           let passwd = tfStack?.textFields[1].text {
            setLoadingVisible()
            enterAction?(login, passwd)
        }
    }
    
    func registerButtonPressed() {
        registerAction?()
    }
    
    func noAccounButtonPressed() {
        //TODO: Action
    }
    
    @objc
    func fogotButtonPressed() {
        forgotPasswordAction?()
    }
    
    @objc
    func endEnditing() {
        self.endEditing(false)
    }
}

