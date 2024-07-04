//
//  ForgotPasswordView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.02.2023.
//

import SnapKit
import UIKit

private let STACK_VIEW_SPACING: CGFloat = 22.scale()
private let STACK_VIEW_HORIZONTAL_OFFSETS: CGFloat = 35.scale()
private let EMAIL_TF_HEIGHT: CGFloat = 55.scale()
private let SEND_BUTTON_HEIGHT: CGFloat = 56.scale()
private let BOTTOM_STACK_INSET: CGFloat = 175.scale()

final class ForgotPasswordView: UIView {
    
    typealias SendAction = (String?) -> Void
    
    private var backAction: EmptyClosure?
    private var sendAction: SendAction?
    
    private lazy var navigationBar: NavigationBarWithLogoAndActions = {
        let navigationBar = NavigationBarWithLogoAndActions(
            frame: .zero,
            buttons: [.back],
            isImageNeed: true
        )
        return navigationBar
    }()
    
    private lazy var restorePasswdLabel: UILabel = {
        let label = UILabel()
        label.font = PartyPointFontFamily.SFProDisplay.semibold.font(size: 30.scale())
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private let emailTF = PPTextField()
    
    private lazy var sendButton: PPButton = {
        let btn = PPButton(style: .primary, size: .l)
        btn.addTarget(self, action: #selector(sendActionHandler), for: .touchUpInside)
        return btn
    }()
    
    private var stackView: UIStackView?
    private var bottomStackConstraint: Constraint?
    private var defaultBottomConstant: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupObservers()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    deinit {
        removeObservers()
    }
    
    func setCloseAction(_ action: @escaping EmptyClosure) {
        self.backAction = action
    }
    
    func setSendAction(_ action: @escaping SendAction) {
        self.sendAction = action
    }
    
    func configure(with title: String, btnTitle: String, textFieldPlaceholder: String) {
        restorePasswdLabel.text = title
        sendButton.setTitle(btnTitle, for: .normal)
        emailTF.placeholder = textFieldPlaceholder
    }
    
    func showError(text: String) {
        emailTF.displayState = .error(text)
    }
    
    func setIsLoading(isLoading: Bool) {
        sendButton.isLoading = isLoading
    }
}

private extension ForgotPasswordView {
    func setupUI() {
        view.backgroundColor = PartyPointAsset.mainColor.color
        view.addTapRecognizer(target: self, action: #selector(endEnditing))
        view.addSubview(navigationBar)
        stackView = UIStackView(
            alignment: .center,
            arrangedSubviews: [restorePasswdLabel, emailTF, sendButton],
            axis: .vertical,
            spacing: STACK_VIEW_SPACING.scale()
        )
        setupConstraints()
        setupAction()
    }
    
    func setupConstraints() {
        navigationBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.snp.top).offset(statusBarFrame.height)
        }
        
        if let stackView = stackView {
            view.addSubview(stackView)
            stackView.snp.makeConstraints {
                $0.left.equalToSuperview().offset(STACK_VIEW_HORIZONTAL_OFFSETS.scale())
                $0.right.equalToSuperview().inset(STACK_VIEW_HORIZONTAL_OFFSETS.scale())
                bottomStackConstraint = $0.bottom.equalToSuperview().inset(BOTTOM_STACK_INSET).constraint
                defaultBottomConstant = bottomStackConstraint?.layoutConstraints[0].constant ?? 0
            }
            
            restorePasswdLabel.snp.makeConstraints {
                $0.width.left.right.equalToSuperview()
            }
            
            emailTF.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
            sendButton.snp.makeConstraints {
                $0.height.equalTo(SEND_BUTTON_HEIGHT)
                $0.right.left.equalToSuperview()
            }
        }
    }
    
    func setupObservers() {
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillShow(_:)),
                                              name: UIWindow.keyboardWillShowNotification,
                                              object: nil)
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillHide(_:)),
                                              name: UIWindow.keyboardWillHideNotification,
                                              object: nil)
    }
    
    func removeObservers() {
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    func setupAction() {
        navigationBar.setBackAction { [weak self] in
            self?.backAction?()
        }
    }
}

// MARK: - Actions -
private extension ForgotPasswordView {
    @objc
    func sendActionHandler() {
        sendAction?(emailTF.text)
    }
}

//MARK: - KeyBoardLogic
extension ForgotPasswordView {
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        let neededHeight = abs(defaultBottomConstant + keyboardFrame.height)
        if self.bottomStackConstraint?.layoutConstraints[0].constant == defaultBottomConstant {
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.bottomStackConstraint?.layoutConstraints[0].constant -= (neededHeight + 5)
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let `self` = self else { return }
            self.bottomStackConstraint?.layoutConstraints[0].constant = self.defaultBottomConstant
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    func endEnditing() {
        view.endEditing(false)
    }
}
