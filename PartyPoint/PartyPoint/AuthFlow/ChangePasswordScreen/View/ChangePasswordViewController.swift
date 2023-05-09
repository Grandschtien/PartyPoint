//
//  ChangePasswordViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.02.2023.
//  
//
import UIKit

final class ChangePasswordViewController: UIViewController {
    
    // MARK: Private propeties
    private let presenter: ChangePasswordPresenter
    private let contentView = ChangePasswordContentView()
    
    // MARK: Init
    init(presenter: ChangePasswordPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupActions()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: Overriden methods
    override func loadView() {
        view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: Private methods
private extension ChangePasswordViewController {
    func setupActions() {
        contentView.setSendNewPasswordAction { [weak self] passwrd, checkPassword in
            self?.presenter.sendNewPassword(password: passwrd, checkPassword: checkPassword)
        }
        
        contentView.setBackAction { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: Public methods
extension ChangePasswordViewController {
    
}

// MARK: ChangePasswordView
extension ChangePasswordViewController: ChangePasswordView {
    func showLoading(isLoading: Bool) {
        contentView.setIsLoading(isLoading: isLoading)
    }
    
    func showError(reason: String) {
        contentView.showError(reason: reason)
    }
    
    func showEmptyFileds() {
        contentView.showEmptyFields()
    }
    
    func performSuccess() {
        guard let navigationController = navigationController else { return }
        for controller in navigationController.viewControllers as Array {
            if controller.isKind(of: EnterViewController.self) {
                navigationController.popToViewController(controller, animated: true)
                break
            }
            
            if controller.isKind(of: ProfileViewController.self) {
                navigationController.popToViewController(controller, animated: true)
            }
        }
    }
}
