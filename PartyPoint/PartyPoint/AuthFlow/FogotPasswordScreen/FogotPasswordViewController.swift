//
//  FogotPasswordViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit
import SnapKit


final class FogotPasswordViewController: UIViewController {
    
    private let forgotPasswordView = ForgotPasswordView()
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
}

private extension FogotPasswordViewController {
    func setupUI() {
        view.addSubview(forgotPasswordView)
        forgotPasswordView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        forgotPasswordView.configure(with: Localizable.restore_password_title(),
                                     btnTitle: Localizable.send_password_button_title(),
                                     textFieldPlaceholder: Localizable.email_title_registration())
        setActions()
    }
    
    func setActions() {
        forgotPasswordView.setCloseAction { [weak self] in
            self?.output.backButtonPressed()
        }
        
        forgotPasswordView.setSendAction { [weak self] email in
            self?.output.sendCode(toEmail: email)
        }
    }
}

extension FogotPasswordViewController: FogotPasswordViewInput {
    func setIsLoading(isLoading: Bool) {
        forgotPasswordView.setIsLoading(isLoading: isLoading)
    }
    
    func performError(reason: String) {
        forgotPasswordView.showError(text: reason)
    }
    
    func showEmailEmpty(errorText: String) {
        forgotPasswordView.showError(text: errorText)
    }
}



