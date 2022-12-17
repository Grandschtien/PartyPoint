//
//  FogotPasswordViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit
import SnapKit

private let STACK_VIEW_SPACING: CGFloat = 22.scale()
private let STACK_VIEW_HORIZONTAL_OFFSETS: CGFloat = 35.scale()
private let EMAIL_TF_HEIGHT: CGFloat = 55.scale()
private let SEND_BUTTON_HEIGHT: CGFloat = 56.scale()

final class FogotPasswordViewController: UIViewController {
    
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
        label.font = Fonts.sfProDisplaySemibold(size: 30)
        label.text = Localizable.restore_password_title()
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private let emailTF = PPTextField(frame: .zero, placeholder: Localizable.email_title_registration())
    
    private lazy var sendButton: AppButton = {
        let btn = AppButton(withTitle: Localizable.send_password_button_title())
        btn.action = { [weak self] in
            self?.sendAction()
        }
        return btn
    }()
    
    private var stackView: UIStackView?
    private var bottomStackConstraint: Constraint?
    private var defaultBottomConstant: CGFloat = 0
    private let output: FogotPasswordViewOutput
    
    init(output: FogotPasswordViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillShow(_:)),
                                              name: UIWindow.keyboardWillShowNotification,
                                              object: nil)
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillHide(_:)),
                                              name: UIWindow.keyboardWillHideNotification,
                                              object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
}

private extension FogotPasswordViewController {
    func setupUI() {
        view.backgroundColor = Colors.mainColor()
        view.addTapRecognizer(target: self, action: #selector(endEnditing))
        view.addSubview(navigationBar)
        stackView = UIStackView(
            alignment: .center,
            arrangedSubviews: [restorePasswdLabel, emailTF, sendButton],
            axis: .vertical,
            spacing: STACK_VIEW_SPACING.scale()
        )
        setupConstraints()
    }
    
    func setupConstraints() {
        navigationBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        if let stackView = stackView {
            view.addSubview(stackView)
            stackView.snp.makeConstraints {
                $0.left.equalToSuperview().offset(STACK_VIEW_HORIZONTAL_OFFSETS.scale())
                $0.right.equalToSuperview().inset(STACK_VIEW_HORIZONTAL_OFFSETS.scale())
                bottomStackConstraint = $0.bottom.equalToSuperview().inset(view.frame.height / 3).constraint
                defaultBottomConstant = bottomStackConstraint?.layoutConstraints[0].constant ?? 0
            }
            
            restorePasswdLabel.snp.makeConstraints {
                $0.width.left.right.equalToSuperview()
            }
            
            emailTF.snp.makeConstraints {
                $0.height.equalTo(EMAIL_TF_HEIGHT)
                $0.left.right.equalToSuperview()
            }
            
            sendButton.snp.makeConstraints {
                $0.height.equalTo(SEND_BUTTON_HEIGHT)
                $0.right.left.equalToSuperview()
            }
        }
        setActions()
    }
    
    func setActions() {
        navigationBar.setBackAction { [weak self] in
            self?.output.backButtonPressed()
        }
    }
}

extension FogotPasswordViewController: FogotPasswordViewInput {
}

//MARK: Actions
extension FogotPasswordViewController {
    private func sendAction() {
        
    }
}

//MARK: - KeyBoardLogic
extension FogotPasswordViewController {
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
