//
//  EnterViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import SnapKit
import UIKit

final class EnterViewController: UIViewController {
    private let enterView = EnterView()
    
    private let output: EnterViewOutput
    
    init(output: EnterViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        setupActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        view = enterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupActions()
        output.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.isNavigationBarHidden = true

        addKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObservers()
    }
}

private extension EnterViewController {
    func setupActions() {
        enterView.setEnterAction { [weak self] login, passwd in
            self?.output.enterButtonPressed(email: login, passwd: passwd)
        }
        
        enterView.setForgotPasswordAction { [weak self] in
            self?.output.fogotPasswordButtonPressed()
        }
        
        enterView.setRegisterAction { [weak self] in
            self?.output.registerButtonPressed()
        }
    }
}

extension EnterViewController: EnterViewInput {
    func showUnAuthorizereaon(reason: String) {
        enterView.setLoadingHide()
        enterView.showUnauthorizeReason(reason: reason)
    }
    
    func showTFIsEmptyView() {
        enterView.setLoadingHide()
        enterView.showTFIsEmptyView()
    }
    
    func showLoginTFIsEmpty() {
        enterView.setLoadingHide()
        enterView.loginTFIsEmpty()
    }
    
    func showPasswordTFIsEmpty() {
        enterView.setLoadingHide()
        enterView.passwordTFIsEmpty()
    }
}

//MARK: - KeyBoardLogic
extension EnterViewController {
    @objc
    func keyboardWillShow(_ notification: Notification) {
        enterView.keyboardWillShow()
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        enterView.keyboardWillHide()
    }
    
    func addKeyboardObservers() {
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillShow(_:)),
                                              name: UIWindow.keyboardWillShowNotification,
                                              object: nil)
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillHide(_:)),
                                              name: UIWindow.keyboardWillHideNotification,
                                              object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
}
