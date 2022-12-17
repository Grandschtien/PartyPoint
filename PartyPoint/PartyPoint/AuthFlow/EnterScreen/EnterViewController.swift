//
//  EnterViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit
import SnapKit

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

private extension EnterViewController {
    func setupActions() {
        enterView.setEnterAction { [weak self] login, passwd in
            Task {
                await self?.output.enterButtonPressed(email: login, passwd: passwd)
            }
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
    func showTFIsEmptyView() {
        enterView.showTFIsEmptyView()
    }
    
    func showError(error: String) {
        
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
}
