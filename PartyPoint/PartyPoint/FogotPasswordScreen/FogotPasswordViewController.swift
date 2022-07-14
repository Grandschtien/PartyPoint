//
//  FogotPasswordViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit

final class FogotPasswordViewController: UIViewController {
    
    private lazy var navigationBar: NavigationBarWithLogoAndActions = {
        let navigationBar = NavigationBarWithLogoAndActions(
            frame: .zero,
            buttons: [.back],
            isImageNeed: true
        )
        navigationBar.delegate = self
        return navigationBar
    }()
    private lazy var restorePasswdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.SFProDisplaySemibold, size: 30)
        label.text = LabelTexts.restorePasswdLabel.rawValue
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    private lazy var emailTF: AppTextField = {
        let tf = AppTextField(frame: .zero, placeholder: LabelTexts.email.rawValue)
        return tf
    }()
    
    private lazy var sendButton: AppButton = {
        let btn = AppButton(withTitle: LabelTexts.sendButton.rawValue)
        btn.action = { [weak self] in
            self?.sendAction()
        }
        return btn
    }()
    
    private var stackView: UIStackView?
    private var bottomStackConstraint: NSLayoutConstraint?
    private var defaultBottomConstant: CGFloat = 0
	private let output: FogotPasswordViewOutput

    init(output: FogotPasswordViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    private func setupUI() {
        view.backgroundColor = .mainColor
        view.addTapRecognizer(target: self, action: #selector(endEnditing))
        view.addConstrained(subview: navigationBar,
                             top: nil,
                             left: 0,
                             bottom: nil,
                             right: 0)
         NSLayoutConstraint.activate([
             navigationBar.heightAnchor.constraint(equalToConstant: 75),
             navigationBar.topAnchor.constraint(
                 equalTo: view.safeAreaLayoutGuide.topAnchor,
                 constant: 0
             )
         ])
        
        stackView = UIStackView(
            alignment: .center,
            arrangedSubviews: [restorePasswdLabel, emailTF, sendButton],
            axis: .vertical,
            spacing: 22)
        if let stackView = stackView {
            view.addConstrained(subview: stackView, top: nil, left: 35, bottom: nil, right: -35)
            bottomStackConstraint = stackView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -view.frame.height / 3
            )
            bottomStackConstraint?.isActive = true
            defaultBottomConstant = bottomStackConstraint?.constant ?? 0
            restorePasswdLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            restorePasswdLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
            restorePasswdLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
            emailTF.heightAnchor.constraint(equalToConstant: 38).isActive = true
            emailTF.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
            emailTF.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
            sendButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
            sendButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
            sendButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        }
    }
}

extension FogotPasswordViewController: FogotPasswordViewInput {
}

extension FogotPasswordViewController: NavigationBarWithLogoAndActionsDelegate {
    func backAction() {
        output.backButtonPressed()
    }
}
//MARK: Actions
extension FogotPasswordViewController {
    private func sendAction() {
        
    }
}

//MARK: - KeyBoardLogic
extension FogotPasswordViewController {@objc
    func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        let neededHeight = abs(defaultBottomConstant + keyboardFrame.height)
        if self.bottomStackConstraint?.constant == defaultBottomConstant {
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.bottomStackConstraint?.constant -= (neededHeight + 5)
                self?.view.layoutIfNeeded()
            }
        }
    }
    @objc
    func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let `self` = self else { return }
            self.bottomStackConstraint?.constant = self.defaultBottomConstant
            self.view.layoutIfNeeded()
        }
    }
    @objc
    func endEnditing() {
        view.endEditing(false)
    }
}
